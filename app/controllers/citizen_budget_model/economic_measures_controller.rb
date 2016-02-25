module CitizenBudgetModel
  class EconomicMeasuresController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_policy_table
    before_action :set_policy_section
    before_action :set_economic_measure, only: [:show, :edit, :update, :destroy]

    def show
    end

    def new
      @economic_measure = collection.new
    end

    def edit
    end

    def create
      @economic_measure = collection.new(economic_measure_params)

      if @economic_measure.save
        redirect_to [@policy_table, @policy_section, @economic_measure], notice: _('Economic Measure was created.')
      else
        render :new
      end
    end

    def update
      if @economic_measure.update(economic_measure_params)
        redirect_to [@policy_table, @policy_section, @economic_measure], notice: _('Economic Measure was updated.')
      else
        render :edit
      end
    end

    def destroy
      @economic_measure.destroy
      redirect_to [@policy_table, @policy_section], notice: _('Economic Measure was deleted.')
    end

  private

    def collection
      @collection ||= @policy_section.economic_measures
    end

    def set_policy_table
      @policy_table = policy_tables.find(params[:policy_table_id])
    end

    def set_policy_section
      @policy_section = @policy_table.policy_sections.find(params[:policy_section_id])
    end

    def set_economic_measure
      @economic_measure = collection.find(params[:id])
    end

    def economic_measure_params
      attribute_names = EconomicMeasure.globalize_attribute_names + [:machine_name, :year_1_value, :year_2_value :question_id]
      params.require(:economic_measure).permit(*attribute_names)
    end
  end
end

