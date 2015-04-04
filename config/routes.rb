Rails.application.routes.draw do
  root 'fields#index'

  resources :documents
  resources :categories
  resources :fields
end
