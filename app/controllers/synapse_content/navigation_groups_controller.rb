module SynapseContent
  class NavigationGroupsController < ActionController::Base
    before_action :set_navigation_group, only: [:show, :edit, :update, :destroy]

    def new
      @navigation_group = NavigationGroup.new
    end

    def create
      @navigation_group = NavigationGroup.create(navigation_group_params)

      respond_to do |format|
        if @navigation_group.save
          format.html { redirect_to main_app.send(SynapseContent.new_navigation_group_redirect_path, @navigation_group), notice: 'Group was created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @navigation_group.update(navigation_group_params)
          format.html { redirect_back(fallback_location: navigation_group_path(@navigation_group), notice: 'Group successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @navigation_group.destroy

      respond_to do |format|
        if params[:nested_parent_id]
          format.html { redirect_to main_app.send(SynapseContent.navigation_groups_path, params[:nested_parent_id]), notice: 'Group was successfully deleted.' }
        else
          format.html { redirect_to main_app.send(SynapseContent.navigation_groups_path), notice: 'Group was successfully deleted.' }
        end
      end
    end

    private

      def set_navigation_group
        @navigation_group = NavigationGroup.find(params[:id])
      end

      def navigation_group_params
        params.require(:navigation_group).permit(:publisher_type, :publisher_id, :title, :position)
      end

  end
end
