module FiatPublication
  class MessagesController < ActionController::Base
    # include ActionView::Helpers::TextHelper
    before_action :set_message, only: [:show, :edit, :update, :destroy]

    def index
      @messages = Message.all
    end

    def new
      @message = Message.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    def create
      @message = Current.publisher.messages.create(message_params)

      respond_to do |format|
        if @message.save
          format.html { redirect_to edit_account_message_path(@message), notice: 'Message successfully saved.' }
        else
          format.html { render action: "new" }
        end
      end
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

    def preview
      @message = Message.find(params[:id])
    end

    def destroy
      @message.destroy

      respond_to do |format|
        format.html { redirect_to account_publisher_messages_path(@message.publisher), notice: 'Message was successfully deleted.' }
      end
    end

    private

      def set_message
        @message = Current.publisher.messages.find(params[:id])
      end

      def message_params
        params.require(:message).permit(:publisher_id, :title, :content, :slug, :image, :excerpt, :image_placement)
      end

  end
end
