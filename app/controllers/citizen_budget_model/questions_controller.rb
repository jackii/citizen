module CitizenBudgetModel
  class QuestionsController < CitizenBudgetModelController
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    def index
      @questions = Question.all
    end

    def show
    end

    def new
      @question = Question.new
    end

    def edit
    end

    def create
      @question = Question.new(question_params)

      if @question.save
        redirect_to @question, notice: _('Question was created.')
      else
        render :new
      end
    end

    def update
      if @question.update(question_params)
        redirect_to @question, notice: _('Question was updated.')
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to questions_url, notice: _('Question was destroyed.')
    end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:section_id, :machine_name, :default_value, :unit_value, :account, :widget, :options, :revenue, :maxlength, :required, :rows, :cols, :size, :name, :title, :description, :modal, :popover, :labels, :unit_name, :placeholder)
    end
  end
end
