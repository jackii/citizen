module CitizenBudgetModel
  class ImpactsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_sensitivity
    before_action :set_sensitivity_section
    before_action :set_impact, only: [:show, :edit, :update, :destroy]

    def show
    end

    def new
      @impact = collection.new
    end

    def edit
    end

    def create
      @impact = collection.new(impact_params)

      if @impact.save
        redirect_to [@sensitivity, @sensitivity_section, @impact], notice: _('Impact was created.')
      else
        render :new
      end
    end

    def update
      if @impact.update(impact_params)
        redirect_to [@sensitivity, @sensitivity_section, @impact], notice: _('Impact was updated.')
      else
        render :edit
      end
    end

    def destroy
      @impact.destroy
      redirect_to [@sensitivity, @sensitivity_section], notice: _('Impact was deleted.')
    end

  private

    def collection
      @collection ||= @sensitivity_section.impacts
    end

    def set_sensitivity
      @sensitivity = sensitivities.find(params[:sensitivity_id])
    end

    def set_sensitivity_section
      @sensitivity_section = @sensitivity.sensitivity_sections.find(params[:sensitivity_section_id])
    end

    def set_impact
      @impact = collection.find(params[:id])
    end

    def impact_params
      attribute_names = EconomicMeasure.globalize_attribute_names + [:machine_name, :year_1_value, :year_2_value, :year_5_value, :year_1_coefficient, :year_2_coefficient, :year_5_coefficient]
      params.require(:impact).permit(*attribute_names)
    end
  end
end


