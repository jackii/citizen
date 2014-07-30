module CitizenBudgetModel
  class SimulatorsController < CitizenBudgetModelController
    before_action :set_simulator, only: [:show, :edit, :update, :destroy, :solution]

    def index
      @simulators = Simulator.all
    end

    def show
    end

    def new
      @simulator = Simulator.new
    end

    def edit
    end

    def create
      @simulator = Simulator.new(simulator_params)

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
      redirect_to simulators_url, notice: _('Simulator was deleted.')
    end

    def solution
      # @todo
    end

  private

    def set_simulator
      @simulator = Simulator.find(params[:id])
    end

    def simulator_params
      params.require(:simulator).permit(:organization_id, :name, :equation)
    end
  end
end
