module CitizenBudgetModel
  class PoliciesController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_multiplier
    before_action :set_policy_section
    before_action :set_policy, only: [:show, :edit, :update, :destroy]

    def show
    end

    def new
      @policy = collection.new
    end

    def edit
    end

    def create
      @policy = collection.new(policy_params)

      if @policy.save
        redirect_to [@multiplier, @policy_section, @policy], notice: _('Policy was created.')
      else
        render :new
      end
    end

    def update
      if @policy.update(policy_params)
        redirect_to [@multiplier, @policy_section, @policy], notice: _('Policy was updated.')
      else
        render :edit
      end
    end

    def destroy
      @policy.destroy
      redirect_to [@multiplier, @policy_section], notice: _('Policy was deleted.')
    end

  private

    def collection
      @collection ||= @policy_section.policies
    end

    def set_multiplier
      @multiplier = multipliers.find(params[:multiplier_id])
    end

    def set_policy_section
      @policy_section = @multiplier.policy_sections.find(params[:policy_section_id])
    end

    def set_policy
      @policy = collection.find(params[:id])
    end

    def policy_params
      attribute_names = Policy.globalize_attribute_names + [:machine_name, :default_value, :year_1_value, :year_2_value, :minimum, :maximum, :step]
      params.require(:policy).permit(*attribute_names)
    end
  end
end

