Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new]
  resources :user, only: [:show, :create, :new]
  resource :session, only: [:create, :new, :destroy]
end
