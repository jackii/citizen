module CitizenBudgetModel
  class PolicyTablesController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_policy_table, only: [:show, :edit, :update, :destroy, :activate, :sort]

    def index
      @policy_tables = collection.all.sort_by(&:name)
    end

    def show
    end

    def new
      @policy_table = collection.new
    end

    def edit
    end

    def create
      @policy_table = collection.new(policy_table_params)

      if @policy_table.save
        redirect_to @policy_table, notice: _('Policy Table was created.')
      else
        render :new
      end
    end

    def update
      if @policy_table.update(policy_table_params)
        redirect_to @policy_table, notice: _('Policy Table was updated.')
      else
        render :edit
      end
    end

    def destroy
      @policy_table.destroy
      redirect_to policy_tables_path, notice: _('Policy Table was deleted.')
    end

    def activate
      @policy_table.activate!
      redirect_to @policy_table, notice: _('Policy Table was activated.')
    end

    def sort
      super(@policy_table.sections)
    end

  private

    def collection
      @collection ||= policy_tables
    end

    def set_policy_table
      @policy_table = collection.find(params[:id])
    end

    def policy_table_params
      attribute_names = PolicyTable.globalize_attribute_names + [:growth_forecast, :employment_coeffiecient, :simulator_id]
      if admin?
        attribute_names << :organization_id
      end
      params.require(:policy_table).permit(*attribute_names)
    end

  end
end
