module SynapseContent
  class MessagesController < ActionController::Base
    # include ActionView::Helpers::TextHelper
    before_action :set_message, only: [:show, :edit, :update, :destroy]

    def index
      @messages = Message.all
    end

    def new
      @message = Message.new
    end

    def create
      @message = Message.create(message_params)

      if defined?(verify_recaptcha)
        success = verify_recaptcha(action: 'create_message', minimum_score: 0.5)
        checkbox_success = verify_recaptcha unless success
        if success || checkbox_success
          respond_to do |format|
            if @message.save
              if params[:notice]
                notice = params[:notice]
              else
                notice = 'Your message was created.'
              end

              if params[:content_label] && SynapseContent::ContentLabel.find_by(name: params[:content_label])
                SynapseContent::ContentLabelAssignment.create(content_label_id: SynapseContent::ContentLabel.find_by(name: params[:content_label]).id, assignable: @message)
              end

              if params[:redirect_path]
                format.html { redirect_to main_app.send(params[:redirect_path]), notice: notice }
              else
                format.html { redirect_to main_app.send(SynapseContent.new_message_redirect_path, @message), notice: notice }
              end
            else
              format.html { redirect_back(fallback_location: new_message_path, alert: "Please check your entry and try again.") }
            end
          end
        else
          if !success
            @show_checkbox_recaptcha = true
          end
          render 'new'
        end
      end
    end

    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if @message.update(message_params)
          format.html { redirect_back(fallback_location: edit_account_message_path(@message), notice: 'Message successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @message.destroy

      respond_to do |format|
        format.html { redirect_to account_publisher_messages_path(@message.publisher), notice: 'Message was successfully deleted.' }
      end
    end

    private

      def set_message
        @message = Message.find(params[:id])
      end

      def message_params
        params.require(:message).permit(:subject, :body, :closed, :global_messageable, :name, :company,
                                        :email, :phone_number, :global_owner, :value, :due_date, :authorable_id, :authorable_type,
                                        custom_fields_attributes: [:id, :publishable_id, :publishable_type,
                                        :field_type, :name, :text_content, :string_content, :numeric_content, :_destroy])
      end

  end
end
