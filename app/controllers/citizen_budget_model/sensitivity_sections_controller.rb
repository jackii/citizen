module CitizenBudgetModel
  class SensitivitySectionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_sensitivity
    before_action :set_sensitivity_section, only: [:show, :edit, :update, :destroy, :sort]

    def show
    end

    def new
      @sensitivity_section = collection.new
    end

    def edit
    end

    def create
      @sensitivity_section = collection.new(sensitivity_section_params)

      if @sensitivity_section.save
        redirect_to [@sensitivity, @sensitivity_section], notice: _('SensitivitySection was created.')
      else
        render :new
      end
    end

    def update
      if @sensitivity_section.update(sensitivity_section_params)
        redirect_to [@sensitivity, @sensitivity_section], notice: _('SensitivitySection was updated.')
      else
        render :edit
      end
    end

    def destroy
      @sensitivity_section.destroy
      redirect_to @sensitivity, notice: _('SensitivitySection was deleted.')
    end

    def sort
      super(@sensitivity_section.questions)
    end

  private

    def collection
      @collection ||= @sensitivity.sensitivity_sections
    end

    def set_sensitivity
      @sensitivity = Sensitivity.find(params[:sensitivity_id])
    end

    def set_sensitivity_section
      @sensitivity_section = collection.find(params[:id])
    end

    def sensitivity_section_params
      attribute_names = SensitivitySection.globalize_attribute_names + [:html_class]
      params.require(:sensitivity_section).permit(*attribute_names)
    end
  end
end

