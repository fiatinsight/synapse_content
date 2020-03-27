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
          if params[:page][:edit_redirect_variable].blank?
            format.html { redirect_to main_app.send(params[:page][:edit_redirect_path], @page), notice: 'Page created.' }
          else
            format.html { redirect_to main_app.send(params[:page][:edit_redirect_path], eval(params[:page][:edit_redirect_variable])), notice: 'Page created.' }
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
        if @page.update(page_params)
          format.html { redirect_back(fallback_location: page_path(@page), notice: 'Page updated.') }
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
        if params[:destroy_redirect_variable].blank?
          format.html { redirect_to main_app.send(params[:destroy_redirect_path], @page), notice: 'Page deleted.' }
        else
          format.html { redirect_to main_app.send(params[:destroy_redirect_path], eval(params[:destroy_redirect_variable])), notice: 'Page deleted.' }
        end
      end
    end

    private

      def set_page
        @page = Page.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:publisher_type, :publisher_id, :title, :slug, :image, :excerpt, :image_placement, :remove_image, :edit_redirect_path, :edit_redirect_variable, :destroy_redirect_path, :destroy_redirect_variable)
      end

  end
end
