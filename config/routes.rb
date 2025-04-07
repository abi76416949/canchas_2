Rails.application.routes.draw do
  devise_for :users, skip: [:sessions], controllers: { registrations: 'registrations' }

#RUTAS PARA DEVISE
  devise_for :users, skip: [:sessions]
  #NO TOCAR  DE ABAJO
  devise_scope :user do
    get 'login', to: 'sessions#new', as: :new_user_session
    post 'login', to: 'sessions#create', as: :user_session
    delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
  end



#NO TOCAR DE ARRIBA
namespace :administrador do
  get 'dashboard', to: 'dashboards#index', as: :dashboard
end

namespace :administrador do
  resources :polideportivos, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :canchas, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :reservas, only: [:index, :new, :create, :edit, :update, :destroy]
    end
  end
end

namespace :administrador do
  resources :propietarios, only: [:index, :new, :create, :edit, :update, :destroy]
end



#NAMESPACE PARA PROPIETARIO
namespace :propi do
  get 'dashboard/edit', to: 'dashboards#edit', as: :edit_dashboard
  patch 'dashboard', to: 'dashboards#update', as: :update_dashboard
  get 'dashboard', to: 'dashboards#index', as: :dashboard
  resources :canchas, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :reservas, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end



    resources :polideportivos do
      resources :canchas do
        resources :reservas, only: [:index, :new, :create] do
      end
    end
  end
  root "polideportivos#index"
end
