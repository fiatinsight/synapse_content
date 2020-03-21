module SynapseContent
  class NavigationItemsController < ActionController::Base
    before_action :set_navigation_item, only: [:show, :edit, :update, :destroy]

    def new
      @navigation_item = NavigationItem.new
    end

    def create
      @navigation_item = NavigationItem.create(navigation_item_params)

      respond_to do |format|
        if @navigation_item.save
          format.html { redirect_to main_app.send(SynapseContent.new_navigation_item_redirect_path, @navigation_item), notice: 'Item was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @navigation_item.update(navigation_item_params)
          format.html { redirect_back(fallback_location: navigation_item_path(@navigation_item), notice: 'Item successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @navigation_item.destroy

      respond_to do |format|
        if params[:nested_parent_id]
          format.html { redirect_to main_app.send(SynapseContent.navigation_items_path, params[:nested_parent_id]), notice: 'Item was successfully deleted.' }
        else
          format.html { redirect_to main_app.send(SynapseContent.navigation_items_path), notice: 'Item was successfully deleted.' }
        end
      end
    end

    private

      def set_navigation_item
        @navigation_item = NavigationItem.find(params[:id])
      end

      def navigation_item_params
        params.require(:navigation_item).permit(:publisher_type, :publisher_id, :title, :navigable_id, :navigable_type, :url, :position, :navigation_group_id, :icon, :global_navigable, :button, :button_position)
      end

  end
end
