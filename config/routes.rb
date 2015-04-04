Rails.application.routes.draw do
  resources :fields
  root 'fields#index'

end
