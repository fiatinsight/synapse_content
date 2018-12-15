module FiatPublication
  class PagesController < ActionController::Base
    # include ActionView::Helpers::TextHelper
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    def index
      # @pages = Current.publisher.pages.order("title ASC").all
      @pages = Page.all
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.create(page_params)

      respond_to do |format|
        if @page.save
          format.html { redirect_to main_app.send(FiatPublication.new_page_redirect_path, @page), notice: 'Page was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @page.update_attributes(page_params)
          format.html { redirect_back(fallback_location: page_path(@page), notice: 'Page successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def preview
      @page = Page.find(params[:id])
    end

    def destroy
      @page.destroy

      respond_to do |format|
        format.html { redirect_to account_publisher_pages_path(@page.publisher), notice: 'Page was successfully deleted.' }
      end
    end

    private

      def set_page
        @page = Page.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:publisher_type, :publisher_id, :title, :slug, :image, :excerpt, :image_placement)
      end

  end
end
