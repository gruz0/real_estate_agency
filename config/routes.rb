Rails.application.routes.draw do
  resources :people
  resources :clients, controller: 'people', type: 'Client'
  resources :employees, controller: 'people', type: 'Employee'
  resources :estate_materials
  resources :estate_projects

  root 'people#index'
end
