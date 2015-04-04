Rails.application.routes.draw do
  root 'home#index'

  resources :documents
  resources :categories
  resources :fields
end
