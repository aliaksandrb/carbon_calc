Rails.application.routes.draw do
  root 'home#index'

  get 'results/index'
  get 'results/insides'
  get 'rules/get_operations' => 'rules#get_operations'

  resources :documents
  resources :categories
  resources :fields
  resources :rules
end
