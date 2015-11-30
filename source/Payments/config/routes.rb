Rails.application.routes.draw do
  resources :charges, param: :unique_code, only: [:show, :new, :create, :index] do
    collection do
      get :search
      get :client_names
    end
  end
  root 'charges#index'
end
