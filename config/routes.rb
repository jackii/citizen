CitizenBudgetModel::Engine.routes.draw do
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
