module CitizenBudgetModel
  class QuestionsController < CitizenBudgetModelController
    before_action :authenticate_user!
    before_action :set_simulator
    before_action :set_section
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    def index
      @questions = Question.where("section_id IS NULL")
    end

    def show
    end

    def new
      if params[:section_id].present?
        @question = collection.new
      else
        @question = Question.new
      end
    end

    def edit
    end

    def create
      if params[:section_id].present?
        @question = collection.new(question_params)
      else
        @question = Question.new(question_params)
      end

      if @question.save
        if params[:section_id].present?
          redirect_to [@simulator, @section, @question], notice: _('Question was created.')
        else
          redirect_to @question, notice: _('Question was created.')
        end
      else
        render :new
      end
    end

    def update
      if @question.update(question_params)
        if params[:section_id].present?
          redirect_to [@simulator, @section, @question], notice: _('Question was updated.')
        else
          redirect_to @question, notice: _('Question was updated.')
        end
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      if params[:section_id].present?
        redirect_to [@simulator, @section], notice: _('Question was deleted.')
      else
        redirect_to questions_path
      end
    end

  private

    def collection
      @collection ||= @section.questions
    end

    def set_simulator
      @simulator = simulators.find(params[:simulator_id]) unless params[:simulator_id].blank?
    end

    def set_section
      @section = @simulator.sections.find(params[:section_id]) unless params[:section_id].blank?
    end

    def set_question
      if params[:section_id].present?
        @question = collection.find(params[:id]) 
      else
        @question = Question.find(params[:id]) 
      end
    end

    def question_params
      attribute_names = Question.globalize_attribute_names + [:machine_name, :default_value, :unit_value_down, :unit_value_up, :account, :widget, :options, :revenue, :maxlength, :required, :rows, :cols, :size, :html_class, :minimum, :maximum, :step, :labels_as_list, :options_as_list]
      params.require(:question).permit(*attribute_names)
    end
  end
end
