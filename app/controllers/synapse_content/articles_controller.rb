module SynapseContent
  class ArticlesController < ActionController::Base
    before_action :set_article, only: [:show, :edit, :update, :destroy, :sort_content_blocks]

    def index
      # @articles = Current.publisher.articles.order("title ASC").all
      @articles = Article.all
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.create(article_params)

      respond_to do |format|
        if @article.save
          if params[:article][:edit_redirect_variable].blank?
            format.html { redirect_to main_app.send(params[:article][:edit_redirect_path], @article), notice: 'Article created.' }
          else
            format.html { redirect_to main_app.send(params[:article][:edit_redirect_path], eval(params[:article][:edit_redirect_variable])), notice: 'Article created.' }
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
        if @article.update(article_params)
          format.html { redirect_back(fallback_location: article_path(@article), notice: 'Article updated.') }
          format.js
        else
          format.html { redirect_back(fallback_location: article_path(@article), alert: "Something went wrong.") }
        end
      end
    end

    def preview
      @article = Article.find(params[:id])
    end

    def destroy
      @article.destroy

      respond_to do |format|
        if params[:destroy_redirect_variable].blank?
          format.html { redirect_to main_app.send(params[:destroy_redirect_path]), notice: 'Article deleted.' }
        else
          format.html { redirect_to main_app.send(params[:destroy_redirect_path], eval(params[:destroy_redirect_variable])), notice: 'Article deleted.' }
        end
      end
    end

    def sort_content_blocks
      params[:new_positions].each_with_index do |id, index|
        ContentBlock.where(id: id).update_all(position: index + 1)
      end

      head :ok
    end

    private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:publisher_type, :publisher_id, :title, :slug, :image, :excerpt, :image_placement, :remove_image, :published_at, :edit_redirect_path, :edit_redirect_variable, :destroy_redirect_path, :destroy_redirect_variable)
      end

  end
end
