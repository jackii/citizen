CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  resources :organizations

  resources :simulators do
    member do
      get :solution
    end
  end

  resources :sections do
    collection do
      post :sort
    end
  end

  resources :questions do
    collection do
      post :sort
    end
  end

  root to: 'simulators#index'
end
