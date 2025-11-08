Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'dashboard/export_csv', to: 'home#export_dashboard_csv', defaults: { format: :csv }
  
  get 'profile', to: 'users#profile'
  patch 'profile', to: 'users#update_profile'
  
  root "home#index"
  
  resources :alunos, only: [:index, :show, :edit, :update, :destroy, :new, :create] do
    collection do
      get :export_pdf
    end
  end
  
  resources :professores, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :export_pdf
    end
  end
  
  resources :planos, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :export_pdf
    end
  end
  
  resources :pagamentos, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :export_pdf
    end
    member do
      get :aluno_data
    end
  end
  
  resources :treinos, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :export_pdf
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
