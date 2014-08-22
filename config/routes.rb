CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  resources :translations, only: [:index, :create]

  resources :organizations

  resources :users, except: [:show, :destroy]

  resources :simulators do
    member do
      get :solution

      post :sort
    end

    resources :sections, except: [:index] do
      member do
        post :sort
      end

      resources :questions, except: [:index]
    end
  end

  namespace :citizen_budget_model do
    get 'pages/home'
  end

  root to: 'pages#home'
end
