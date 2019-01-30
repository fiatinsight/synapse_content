module FiatPublication
  class CustomFieldsController < ActionController::Base
    before_action :set_custom_field, only: [:show, :edit, :update, :destroy]

    def new
      @custom_field = CustomField.new

      respond_to do |format|
        format.html
        format.js
      end
    end

    def create
      @custom_field = CustomField.create(custom_field_params)

      respond_to do |format|
        if @custom_field.save
          format.html { redirect_back(fallback_location: custom_fields_path, notice: 'New field was created.') }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @custom_field.update_attributes(custom_field_params)
          format.html { redirect_back(fallback_location: custom_fields_path, notice: 'Field successfully updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @custom_field.destroy

      respond_to do |format|
        format.html { redirect_back(fallback_location: custom_fields_path, notice: 'Field was removed.') }
      end
    end

    private

      def set_custom_field
        @custom_field = CustomField.find(params[:id])
      end

      def custom_field_params
        params.require(:custom_field).permit(:publishable_type, :publishable_id, :field_type, :name, :text_content,
                                              :string_content, :numeric_content)
      end

  end
end
