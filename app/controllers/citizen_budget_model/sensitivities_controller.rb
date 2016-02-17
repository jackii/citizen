module CitizenBudgetModel
  class SensitivitiesController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_sensitivity, only: [:show, :edit, :update, :destroy, :activate, :sort]

    def index
      @sensitivities = collection.all.sort_by(&:name)
    end

    def show
    end

    def new
      @sensitivity = collection.new
    end

    def edit
    end

    def create
      @sensitivity = collection.new(sensitivity_params)

      if @sensitivity.save
        redirect_to @sensitivity, notice: _('Sensitivity was created.')
      else
        render :new
      end
    end

    def update
      if @sensitivity.update(sensitivity_params)
        redirect_to @sensitivity, notice: _('Sensitivity was updated.')
      else
        render :edit
      end
    end

    def destroy
      @sensitivity.destroy
      redirect_to sensitivities_path, notice: _('Sensitivity was deleted.')
    end

  private

    def collection
      @collection ||= sensitivities
    end

    def set_sensitivity
      @sensitivity = collection.find(params[:id])
    end

    def sensitivity_params
      attribute_names = Sensitivity.globalize_attribute_names
      if admin?
        attribute_names << :organization_id
      end
      params.require(:sensitivity).permit(*attribute_names)
    end
  end
end

