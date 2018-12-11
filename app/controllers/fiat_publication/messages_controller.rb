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
          format.html { redirect_to main_app.message_path(@message), notice: 'Message was created.' }
        else
          format.html { render action: "new" }
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
        params.require(:message).permit(:subject, :body)
      end

  end
end
