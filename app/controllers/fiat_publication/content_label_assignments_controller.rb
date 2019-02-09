module FiatPublication
  class ContentLabelAssignmentsController < ActionController::Base
    before_action :set_content_label_assignment, only: [:show, :destroy]

    def new
      @content_label_assignment = ContentLabelAssignment.new

      respond_to do |format|
        format.js
      end
    end

    # def create
    #   @content_label_assignment = ContentLabelAssignment.create(content_label_assignment_params)
    #
    #   respond_to do |format|
    #     if @content_label_assignment.save
    #       format.html { redirect_back(fallback_location: content_label_assignments_path, notice: 'Label was added.') }
    #     else
    #       format.html { render action: "new" }
    #     end
    #   end
    # end

    def create
      unless FiatPublication::ContentLabelAssignment.find_by(content_label_id: params[:content_label_id], assignable_type: params[:assignable_type], assignable_id: params[:assignable_id])
        @content_label_assignment = FiatPublication::ContentLabelAssignment.create(content_label_id: params[:content_label_id], assignable_type: params[:assignable_type], assignable_id: params[:assignable_id])
      end

      respond_to do |format|
        if @content_label_assignment.save
          format.js { render :partial => 'fiat_publication/content_label_assignments/create.js.erb', layout: false }
        end
      end
    end

    def destroy
      @content_label_assignment.destroy

      respond_to do |format|
        format.html { redirect_back(fallback_location: content_label_assignments_path, notice: 'Label was removed.') }
      end
    end

    private

      def set_content_label_assignment
        @content_label_assignment = ContentLabelAssignment.find(params[:id])
      end

      def content_label_assignment_params
        params.require(:content_label_assignment).permit(:content_label_id, :assignable_type, :assignable_id)
      end

  end
end
