module CitizenBudgetModel
  class MultipliersController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_multiplier, only: [:show, :edit, :update, :destroy, :activate, :sort]

    def index
      @multipliers = collection.all.sort_by(&:name)
    end

    def show
    end

    def new
      @multiplier = collection.new
    end

    def edit
    end

    def create
      @multiplier = collection.new(multiplier_params)

      if @multiplier.save
        redirect_to @multiplier, notice: _('Multiplier was created.')
      else
        render :new
      end
    end

    def update
      if @multiplier.update(multiplier_params)
        redirect_to @multiplier, notice: _('Multiplier was updated.')
      else
        render :edit
      end
    end

    def destroy
      @multiplier.destroy
      redirect_to multipliers_path, notice: _('Multiplier was deleted.')
    end

    def activate
      @multiplier.activate!
      redirect_to @multiplier, notice: _('Multiplier was activated.')
    end

    def sort
      super(@multiplier.sections)
    end

  private

    def collection
      @collection ||= multipliers
    end

    def set_multiplier
      @multiplier = collection.find(params[:id])
    end

    def multiplier_params
      attribute_names = Multiplier.globalize_attribute_names + [:growth_forecast, :employment_coeffiecient, :simulator_id]
      if admin?
        attribute_names << :organization_id
      end
      params.require(:multiplier).permit(*attribute_names)
    end

  end
end
