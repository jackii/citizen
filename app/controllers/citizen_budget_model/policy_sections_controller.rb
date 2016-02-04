module CitizenBudgetModel
  class PolicySectionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_multiplier
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
        redirect_to [@multiplier, @policy_section], notice: _('PolicySection was created.')
      else
        render :new
      end
    end

    def update
      if @policy_section.update(policy_section_params)
        redirect_to [@multiplier, @policy_section], notice: _('PolicySection was updated.')
      else
        render :edit
      end
    end

    def destroy
      @policy_section.destroy
      redirect_to @multiplier, notice: _('PolicySection was deleted.')
    end

    def sort
      super(@policy_section.questions)
    end

  private

    def collection
      @collection ||= @multiplier.policy_sections
    end

    def set_multiplier
      @multiplier = multipliers.find(params[:multiplier_id])
    end

    def set_policy_section
      @policy_section = collection.find(params[:id])
    end

    def policy_section_params
      attribute_names = PolicySection.globalize_attribute_names + [:html_class]
      params.require(:policy_section).permit(*attribute_names)
    end
  end
end

