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
      @comment = Comment.create(comment_params)

      respond_to do |format|
        if @comment.save
          format.html { redirect_back(fallback_location: main_app.send(FiatPublication.new_comment_redirect_path, @comment), notice: 'Comment was created.') }
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
        if @comment.update_attributes(comment_params)
          format.html { redirect_back(fallback_location: edit_account_comment_path(@comment), notice: 'Comment successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to account_publisher_comments_path(@comment.publisher), notice: 'Comment was successfully deleted.' }
      end
    end

    private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body, :authorable_type, :authorable_id, :commentable_type, :commentable_id)
      end

  end
end
