Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  ###
  devise_for :users
  resources :restaurants, only: [:new, :create] do
    resources :bussiness_hours, only: [:index, :edit, :update]
  end
  root "home#index"
end
