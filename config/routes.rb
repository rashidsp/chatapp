Rails.application.routes.draw do
	

  devise_for :users, controllers: {
  	sessions: 'users/sessions'
  }
  resources :home


  resources :conversations do
    resources :messages
  end
  root 'conversations#index'

  resources :users do
    resources :friendships
  end

  get "/validate_email" => "home#validate_email", :as => "validate_email"
  get "/contacts" => "users#index", :as => "contacts"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
