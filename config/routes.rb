Rails.application.routes.draw do
  devise_for :employees, path: 'auth', controllers: {
    sessions: 'admin/sessions'
  }

  resources :competitors
  resources :clients
  resources :employees
  resources :estate_materials
  resources :estate_projects
  resources :estate_types
  resources :cities do
    resources :streets do
      resources :addresses, only: %i[index show destroy]
      get 'search', on: :collection
    end
  end
  resources :estates

  root 'estates#index'
end
