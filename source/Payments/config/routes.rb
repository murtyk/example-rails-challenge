Rails.application.routes.draw do
  resources :charges, param: :unique_code, only: [:show, :new, :create, :index]
  root 'charges#index'
end
