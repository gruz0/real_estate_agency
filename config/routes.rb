Rails.application.routes.draw do
  resources :clients
  resources :employees
  resources :estate_materials
  resources :estate_projects
  resources :estate_types
  resources :cities do
    resources :streets
  end
  resources :estates

  root 'estates#index'
end
