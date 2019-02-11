module FiatPublication
  class AttachmentsController < ActionController::Base
    before_action :set_attachment, only: [:show, :edit, :update, :destroy]

    def new
      @attachment = Attachment.new
    end

    def create
      @attachment = Attachment.create(attachment_params)

      respond_to do |format|
        if @attachment.save
          format.html { redirect_to main_app.send(FiatPublication.new_attachment_redirect_path, @attachment), notice: 'Attachment was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @attachment.update_attributes(attachment_params)
          format.html { redirect_back(fallback_location: attachment_path(@attachment), notice: 'Attachment successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @attachment.destroy

      respond_to do |format|
        format.html { redirect_to attachments_path, notice: 'Attachment was successfully deleted.' }
      end
    end

    private

      def set_attachment
        @attachment = Attachment.find(params[:id])
      end

      def attachment_params
        params.require(:attachment).permit(:publisher_type, :publisher_id, :title, :file)
      end

  end
end
