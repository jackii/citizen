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
      @variables = @sensitivity.variables
      ['Year 1', 'Year 2', 'Year 5'].each do |year|
        @variables.each do |variable|
          @impact.impact_variables.build(variable: variable, year: year)
        end
      end
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

        respond_to do |format|
          format.html {
            redirect_to [@sensitivity, @sensitivity_section, @impact], notice: _('Impact was updated.')
          }
          format.json {
            render json: @impact.to_json
          }
        end
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
      attribute_names = EconomicMeasure.globalize_attribute_names + [:machine_name, :is_public, :year_1_formula, :year_1_excel_formula, :year_2_formula, :year_2_excel_formula, :year_5_formula, :year_5_excel_formula, :impact_variables_attributes => [ :id, :year, :variable_id, :impact_id, :coefficient, :prepopulated_result ]]
      params.require(:impact).permit(*attribute_names)
    end
  end
end


