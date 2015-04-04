Rails.application.routes.draw do
  resources :rules
  root 'home#index'

  resources :documents
  resources :categories
  resources :fields
end
