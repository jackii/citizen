module CitizenBudgetModel
  class SimulatorsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_simulator, only: [:show, :edit, :update, :destroy, :activate, :sort]

    def index
      @simulators = collection.all.sort_by(&:name)
    end

    def show
    end

    def new
      @simulator = collection.new
    end

    def edit
    end

    def create
      @simulator = collection.new(simulator_params)

      if @simulator.save
        redirect_to @simulator, notice: _('Simulator was created.')
      else
        render :new
      end
    end

    def update
      if @simulator.update(simulator_params)
        redirect_to @simulator, notice: _('Simulator was updated.')
      else
        render :edit
      end
    end

    def destroy
      @simulator.destroy
      redirect_to simulators_path, notice: _('Simulator was deleted.')
    end

    def activate
      @simulator.activate!
      redirect_to @simulator, notice: _('Simulator was activated.')
    end

    def sort
      super(@simulator.sections)
    end

  private

    def collection
      @collection ||= simulators
    end

    def set_simulator
      @simulator = collection.find(params[:id])
    end

    def simulator_params
      attribute_names = Simulator.globalize_attribute_names + [:equation, :total_revenue]
      if admin?
        attribute_names << :organization_id
      end
      params.require(:simulator).permit(*attribute_names)
    end
  end
end
