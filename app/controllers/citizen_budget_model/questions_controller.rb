module CitizenBudgetModel
  class QuestionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_simulator
    before_action :set_section
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    def show
    end

    def new
      @question = collection.new
    end

    def edit
    end

    def create
      @question = collection.new(question_params)

      if @question.save
        redirect_to [@simulator, @section, @question], notice: _('Question was created.')
      else
        render :new
      end
    end

    def update
      if @question.update(question_params)
        redirect_to [@simulator, @section, @question], notice: _('Question was updated.')
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to [@simulator, @section], notice: _('Question was deleted.')
    end

  private

    def collection
      @collection ||= @section.questions
    end

    def set_simulator
      @simulator = simulators.find(params[:simulator_id])
    end

    def set_section
      @section = @simulator.sections.find(params[:section_id])
    end

    def set_question
      @question = collection.find(params[:id])
    end

    def question_params
      attribute_names = Question.globalize_attribute_names + [:machine_name, :default_value, :unit_value, :account, :widget, :options, :revenue, :maxlength, :required, :rows, :cols, :size, :html_class]
      params.require(:question).permit(*attribute_names)
    end
  end
end
