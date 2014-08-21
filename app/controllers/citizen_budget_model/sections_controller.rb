module CitizenBudgetModel
  class SectionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_simulator
    before_action :set_section, only: [:show, :edit, :update, :destroy, :sort]

    def show
    end

    def new
      @section = collection.new
    end

    def edit
    end

    def create
      @section = collection.new(section_params)

      if @section.save
        redirect_to [@simulator, @section], notice: _('Section was created.')
      else
        render :new
      end
    end

    def update
      if @section.update(section_params)
        redirect_to [@simulator, @section], notice: _('Section was updated.')
      else
        render :edit
      end
    end

    def destroy
      @section.destroy
      redirect_to @simulator, notice: _('Section was destroyed.')
    end

    def sort
      @section.questions.each do |question|
        question.update_attributes position: params[:question].index(question.id.to_s)
      end
      render nothing: true, status: 204
    end

  private

    def collection
      @collection ||= @simulator.sections
    end

    def set_simulator
      @simulator = simulators.find(params[:simulator_id])
    end

    def set_section
      @section = collection.find(params[:id])
    end

    def section_params
      attribute_names = Section.globalize_attribute_names
      params.require(:section).permit(attribute_names)
    end
  end
end
