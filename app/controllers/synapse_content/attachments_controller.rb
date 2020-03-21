module SynapseContent
  class AttachmentsController < ActionController::Base
    before_action :set_attachment, only: [:show, :edit, :update, :destroy]

    def show
      redirect_to url_for(@attachment.file)
    end

    def new
      @attachment = Attachment.new
    end

    def create
      @attachment = Attachment.create(attachment_params)

      respond_to do |format|
        if @attachment.save
          format.html { redirect_to main_app.send(SynapseContent.new_attachment_redirect_path, @attachment), notice: 'Attachment was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @attachment.update(attachment_params)
          format.html { redirect_back(fallback_location: attachment_path(@attachment), notice: 'Attachment successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @attachment.destroy

      respond_to do |format|
        if params[:nested_parent_id]
          format.html { redirect_to main_app.send(SynapseContent.attachments_path, params[:nested_parent_id]), notice: 'Attachment was successfully deleted.' }
        else
          format.html { redirect_to main_app.send(SynapseContent.attachments_path), notice: 'Attachment was successfully deleted.' }
        end
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
