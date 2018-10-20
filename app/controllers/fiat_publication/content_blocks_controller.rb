module FiatPublication
  class ContentBlocksController < ActionController::Base
    before_action :set_content_block, only: [:show, :edit, :update, :destroy]

    def new
      @content_block = ContentBlock.new

      respond_to do |format|
        format.js
      end
    end

    def create
      @content_block = ContentBlock.create(content_block_params)

      respond_to do |format|
        if @content_block.save
          format.html { redirect_back(fallback_location: content_blocks_path, notice: 'New block was created.') }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @content_block.update_attributes(content_block_params)
          format.html { redirect_back(fallback_location: content_blocks_path, notice: 'Block successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @content_block.destroy

      respond_to do |format|
        format.html { redirect_to account_parish_content_blocks_path(@content_block.parish), notice: 'ContentBlock was successfully deleted.' }
      end
    end

    private

      def set_content_block
        @content_block = ContentBlock.find(params[:id])
      end

      def content_block_params
        params.require(:content_block).permit(:publishable_type, :publishable_id, :block_type, :priority, :text_content,
                                              :image)
      end

  end
end
