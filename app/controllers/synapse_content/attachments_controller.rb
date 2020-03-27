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
          if params[:attachment][:edit_redirect_variable].blank?
            format.html { redirect_to main_app.send(params[:attachment][:edit_redirect_path], @attachment), notice: 'Attachment created.' }
          else
            format.html { redirect_to main_app.send(params[:attachment][:edit_redirect_path], eval(params[:attachment][:edit_redirect_variable])), notice: 'Attachment created.' }
          end
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
          format.html { redirect_back(fallback_location: attachment_path(@attachment), notice: 'Attachment updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @attachment.destroy

      respond_to do |format|
        if params[:destroy_redirect_variable].blank?
          format.html { redirect_to main_app.send(params[:destroy_redirect_path], @attachment), notice: 'Attachment deleted.' }
        else
          format.html { redirect_to main_app.send(params[:destroy_redirect_path], eval(params[:destroy_redirect_variable])), notice: 'Attachment deleted.' }
        end
      end
    end

    private

      def set_attachment
        @attachment = Attachment.find(params[:id])
      end

      def attachment_params
        params.require(:attachment).permit(:publisher_type, :publisher_id, :title, :file, :edit_redirect_path, :edit_redirect_variable, :destroy_redirect_path, :destroy_redirect_variable)
      end

  end
end
