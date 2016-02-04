module CitizenBudgetModel
  class VariablesController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_sensitivity
    before_action :set_variable, only: [:show, :edit, :update, :destroy]

    def show
    end

    def new
      @variable = collection.new
    end

    def edit
    end

    def create
      @variable = collection.new(variable_params)

      if @variable.save
        redirect_to [@sensitivity, @variable], notice: _('Variable was created.')
      else
        render :new
      end
    end

    def update
      if @variable.update(variable_params)
        redirect_to [@sensitivity, @variable], notice: _('Variable was updated.')
      else
        render :edit
      end
    end

    def destroy
      @variable.destroy
      redirect_to [@sensitivity], notice: _('Variable was deleted.')
    end

  private

    def collection
      @collection ||= @sensitivity.variables
    end

    def set_sensitivity
      @sensitivity = Sensitivity.find(params[:sensitivity_id])
    end

    def set_variable
      @variable = collection.find(params[:id])
    end

    def variable_params
      attribute_names = Variable.globalize_attribute_names + [:machine_name, :default_value, :pbo_assumption, :minimum, :maximum, :step, :question_id]
      params.require(:variable).permit(*attribute_names)
    end
  end
end


