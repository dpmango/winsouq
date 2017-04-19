Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/:id/welcome', to: "users/registrations#welcome", as: :user_welcome
    get 'users/:id/myshops', to: "users/registrations#myshops", as: :my_shops
  end

  # static pages
  root to: "static#index"
  get '/about', to: "static#about"
  get '/contact', to: "static#contact"
  get '/faq', to: "static#faq"
  get '/terms', to: "static#terms"


  resources :shops
  resources :products
  resources :categories

  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]

  resources :favorite_products, only: [:index, :create, :destroy]
  resources :favorite_shops, only: [:index, :create, :destroy]
  resources :views, only: [:index]

  resources :socials, only: [:destroy]
  resources :payments, only: [:destroy]

  mount ActionCable.server => '/cable'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
