module CitizenBudgetModel
  class SectionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_section, only: [:show, :edit, :update, :destroy, :sort]

    def index
      @sections = Section.all
    end

    def show
    end

    def new
      @section = Section.new
    end

    def edit
    end

    def create
      @section = Section.new(section_params)

      if @section.save
        redirect_to @section, notice: _('Section was created.')
      else
        render :new
      end
    end

    def update
      if @section.update(section_params)
        redirect_to @section, notice: _('Section was updated.')
      else
        render :edit
      end
    end

    def destroy
      @section.destroy
      redirect_to sections_url, notice: _('Section was destroyed.')
    end

    def sort
      @section.questions.each do |question|
        question.update_attributes position: params[:question].index(question.id.to_s)
      end
      render nothing: true, status: 204
    end

  private

    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      attribute_names = Section.globalize_attribute_names + [:simulator_id]
      params.require(:section).permit(attribute_names)
    end
  end
end
