CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  resources :organizations

  resources :simulators do
    member do
      get :solution
    end
  end

  resources :sections

  resources :questions

  root to: 'simulators#index'
end
