module CitizenBudgetModel
  class PolicySectionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_policy_table
    before_action :set_policy_section, only: [:show, :edit, :update, :destroy, :sort]

    def show
    end

    def new
      @policy_section = collection.new
    end

    def edit
    end

    def create
      @policy_section = collection.new(policy_section_params)

      if @policy_section.save
        redirect_to [@policy_table, @policy_section], notice: _('PolicySection was created.')
      else
        render :new
      end
    end

    def update
      if @policy_section.update(policy_section_params)
        redirect_to [@policy_table, @policy_section], notice: _('PolicySection was updated.')
      else
        render :edit
      end
    end

    def destroy
      @policy_section.destroy
      redirect_to @policy_table, notice: _('PolicySection was deleted.')
    end

    def sort
      super(@policy_section.economic_measures)
    end

  private

    def collection
      @collection ||= @policy_table.policy_sections
    end

    def set_policy_table
      @policy_table = policy_tables.find(params[:policy_table_id])
    end

    def set_policy_section
      @policy_section = collection.find(params[:id])
    end

    def policy_section_params
      attribute_names = PolicySection.globalize_attribute_names
      params.require(:policy_section).permit(*attribute_names)
    end
  end
end

