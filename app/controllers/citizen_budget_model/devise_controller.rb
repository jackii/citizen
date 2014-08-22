module CitizenBudgetModel
  class DeviseController < CitizenBudgetModelController
    layout 'citizen_budget_model/devise'

    def after_sign_in_path_for(resource)
      simulators_path
    end
  end
end
