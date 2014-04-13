CitizenBudgetModel::Engine.routes.draw do
  resources :simulators do
    member do
      get :solution
    end
  end

  root to: 'simulators#index'
end
