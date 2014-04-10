Rails.application.routes.draw do

  mount CitizenBudgetModel::Engine => "/citizen_budget_model"
end
