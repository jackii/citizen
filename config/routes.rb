CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  resources :organizations

  resources :simulators do
    member do
      post :sort
      get :solution
    end
  end

  resources :sections do
    member do
      post :sort
    end
  end

  resources :questions

  namespace :citizen_budget_model do
    get 'pages/home'
  end

  root to: 'pages#home'
end
