module SynapseContent
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
          format.html { redirect_to main_app.send(SynapseContent.new_page_redirect_path, @page), notice: 'Page was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_back(fallback_location: page_path(@page), notice: 'Page successfully updated.') }
          format.js
        else
          format.html { redirect_back(fallback_location: page_path(@page), alert: "Something went wrong.") }
        end
      end
    end

    def preview
      @page = Page.find(params[:id])
    end

    def destroy
      @page.destroy

      respond_to do |format|
        if params[:nested_parent_id]
          format.html { redirect_to main_app.send(SynapseContent.pages_path, params[:nested_parent_id]), notice: 'Page was successfully deleted.' }
        else
          format.html { redirect_to main_app.send(SynapseContent.pages_path), notice: 'Page was successfully deleted.' }
        end
      end
    end

    private

      def set_page
        @page = Page.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:publisher_type, :publisher_id, :title, :slug, :image, :excerpt, :image_placement, :remove_image)
      end

  end
end
