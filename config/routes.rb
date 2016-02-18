CitizenBudgetModel::Engine.routes.draw do
  devise_for :users, class_name: 'CitizenBudgetModel::User', module: :devise

  resources :translations, only: [:index, :create] do
    collection do
      get :export
    end
  end

  resources :organizations

  resources :users, except: [:show, :destroy]

  resources :policy_tables do
    member do
      post :activate
    end

    resources :policy_sections, except: [:index] do
      member do
        post :sort
      end

      resources :economic_measures, except: [:index]
    end
  end

  resources :sensitivities do
    resources :variables, except: [:index] do
      member do
        post :sort
      end
    end

    resources :sensitivity_sections, except: [:index] do
      member do
        post :sort
      end
    end
  end

  resources :simulators do
    member do
      post :sort
      post :activate
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
