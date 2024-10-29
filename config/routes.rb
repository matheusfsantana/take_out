Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  devise_for :users
  resources :restaurants, only: [:new, :create] do
    resources :dishes
    resources :beverages
    resources :bussiness_hours, only: [:index, :edit, :update]

    get 'menu_items/search', to: 'menu_items#search'
    post 'update_menu_item_status/:menu_item_id', to: "menu_items#update_status", as: 'update_menu_item_status'
  end
  root "home#index"
end
