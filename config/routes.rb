CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
