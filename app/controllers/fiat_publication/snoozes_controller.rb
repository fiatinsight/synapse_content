module FiatPublication
  class SnoozesController < ActionController::Base
    before_action :set_snooze, only: [:show, :edit, :update, :destroy]

    def new
      @snooze = Snooze.new
    end

    def create
      @snooze = Snooze.create(snooze_params)

      respond_to do |format|
        if @snooze.save
          format.html { redirect_back(fallback_location: main_app.root_path, notice: 'Snooze saved.') }
        else
          format.html { render action: "new" }
        end
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @snooze.update_attributes(snooze_params)
          format.html { redirect_back(fallback_location: snooze_path(@snooze), notice: 'Snooze updated.') }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @snooze.destroy

      respond_to do |format|
        format.html { redirect_back(fallback_location: main_app.root_path, notice: 'Snooze removed.') }
      end
    end

    def auto_unsnooze
      Snooze.past_due.destroy_all
    end

    private

      def set_snooze
        @snooze = Snooze.find(params[:id])
      end

      def snooze_params
        params.require(:snooze).permit(:snoozable_id, :snoozable_type, :snoozer_id, :snoozer_type_class, :snoozer_type_method, :unsnooze_date, :unsnooze_time)
      end

  end
end
