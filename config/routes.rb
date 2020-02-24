Rails.application.routes.draw do
  devise_for :employees, path: 'auth', controllers: {
    sessions: 'admin/sessions'
  }

  resources :competitors
  resources :clients
  resources :employees, only: %i[index show new create edit update] do
    post 'lock', on: :member
    post 'unlock', on: :member
  end
  resources :estate_materials
  resources :estate_projects
  resources :estate_types
  resources :cities do
    resources :streets do
      get 'search', on: :collection
    end
  end
  resources :addresses, only: %i[index show destroy]
  resources :estates do
    patch :delay, on: :member
    delete :cancel_delay, on: :member
  end
  resources :audits, only: %i[index show]
  namespace :services do
    resources :reassign_estates, only: %i[index]
    put :reassign_estates, to: 'reassign_estates#update'
  end

  root 'estates#index'
end
