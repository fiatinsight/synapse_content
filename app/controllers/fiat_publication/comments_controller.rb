module FiatPublication
  class CommentsController < ActionController::Base
    # include ActionView::Helpers::TextHelper
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    def index
      @comments = Comment.all
    end

    def new
      @comment = Comment.new
    end

    def create
      @comment = Current.publisher.comments.create(comment_params)

      respond_to do |format|
        if @comment.save
          format.html { redirect_to edit_account_comment_path(@comment), notice: 'Comment successfully saved.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @comment.update_attributes(comment_params)
          format.html { redirect_back(fallback_location: edit_account_comment_path(@comment), notice: 'Comment successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def preview
      @comment = Comment.find(params[:id])
    end

    def destroy
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to account_publisher_comments_path(@comment.publisher), notice: 'Comment was successfully deleted.' }
      end
    end

    private

      def set_comment
        @comment = Current.publisher.comments.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:publisher_id, :title, :content, :slug, :image, :excerpt, :image_placement)
      end

  end
end
