Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :results do
    get 'index'
    get 'insides'
    get 'insides_historical'
  end

  get 'rules/get_operations' => 'rules#get_operations'

  resources :documents
  resources :categories
  resources :fields
  resources :rules
end
