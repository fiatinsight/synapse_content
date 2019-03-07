module FiatPublication
  class ArticlesController < ActionController::Base
    # include ActionView::Helpers::TextHelper
    before_action :set_article, only: [:show, :edit, :update, :destroy]

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
          format.html { redirect_to main_app.send(FiatPublication.new_article_redirect_path, @article), notice: 'Article was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @article.update_attributes(article_params)
          format.html { redirect_back(fallback_location: article_path(@article), notice: 'Article successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def preview
      @article = Article.find(params[:id])
    end

    def destroy
      @article.destroy

      respond_to do |format|
        if params[:nested_parent_id]
          format.html { redirect_to main_app.send(FiatPublication.articles_path, params[:nested_parent_id]), notice: 'Article was successfully deleted.' }
        else
          format.html { redirect_to main_app.send(FiatPublication.articles_path), notice: 'Article was successfully deleted.' }
        end
      end
    end

    private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:publisher_type, :publisher_id, :title, :slug, :image, :excerpt, :image_placement,
                                        :published_at)
      end

  end
end
