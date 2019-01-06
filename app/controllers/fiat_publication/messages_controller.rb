module FiatPublication
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

      respond_to do |format|
        if @message.save
          if params[:notice]
            notice = params[:notice]
          else
            notice = 'Your message was created.'
          end

          if params[:content_label] && FiatPublication::ContentLabel.find_by(name: params[:content_label])
            FiatPublication::ContentLabelAssignment.create(content_label_id: FiatPublication::ContentLabel.find_by(name: params[:content_label]).id, assignable: @message)
          end

          if params[:redirect_path]
            format.html { redirect_to main_app.send(params[:redirect_path]), notice: notice }
          else
            format.html { redirect_to main_app.send(FiatPublication.new_message_redirect_path, @message), notice: notice }
          end
        else
          format.html { redirect_back(fallback_location: new_message_path, alert: "Please check your entry and try again.") } #format.html { render action: "new" }
        end
      end
    end

    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if @message.update_attributes(message_params)
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
                                        :email, :phone_number, :global_owner, :value, :due_date)
      end

  end
end
