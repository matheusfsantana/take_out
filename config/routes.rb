Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }  
  resources :employees, only: [:index, :new, :create]
  resources :restaurants, only: [:new, :create] do
    resources :tags, only: [:index, :new, :create, :edit, :update]
    resources :dishes 
    resources :beverages 
    resources :menus, only: [:new, :create, :show] do
      resources :orders, only: [:new, :create]
    end
    resources :customers, only: [:new, :create]
    resources :items, only: [] do
      resources :options, controller: 'item_options', only: [:new, :create, :edit, :update]
      resources :option_historicals, only: [:index]
    end
    resources :bussiness_hours, only: [:index, :edit, :update]
    
    get 'items/search', to: 'items#search'
    post 'update_item_status/:item_id', to: "items#update_status", as: 'update_item_status'
  end
  resources :orders, only: [] do
     member do
       get 'confirm', to: 'orders#confirm_order'
       post 'confirm', to: 'orders#confirm_order_status'
     end
  end
  root "home#index"
end
