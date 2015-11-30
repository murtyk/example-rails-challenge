Rails.application.routes.draw do
  resources :charges, only: [:index, :show, :new, :create]

  root 'charges#index'
end
