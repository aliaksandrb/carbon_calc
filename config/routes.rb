Rails.application.routes.draw do
  resources :categories
  resources :fields
  root 'fields#index'

end
