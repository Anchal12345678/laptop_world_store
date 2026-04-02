Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  get    "cart",              to: "cart#show",   as: :cart
  post   "cart/add/:id",      to: "cart#add",    as: :cart_add
  post   "cart/update/:id",   to: "cart#update", as: :cart_update
  delete "cart/remove/:id",   to: "cart#remove", as: :cart_remove

  get  "checkout", to: "checkout#show",  as: :checkout
  post "checkout", to: "checkout#create"

  resources :orders, only: [:index, :show]

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get 'contact', to: 'pages#contact', as: :contact
  get 'about', to: 'pages#about', as: :about
  get  'address/edit', to: 'addresses#edit', as: :edit_address
  patch 'address/update', to: 'addresses#update', as: :update_address
  get  'payment/new', to: 'payments#new', as: :new_payment
  post 'payment/create', to: 'payments#create', as: :create_payment
end