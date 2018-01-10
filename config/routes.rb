Rails.application.routes.draw do

root 'users#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :listings, except: :index do
    resources :reservations, only: [:new]
  end

  resources :reservations, only: [:create, :destroy]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "/users/:id/show" => "users#show", as: "user_show"
  get "/users/:id/edit" => "users#edit", as: "user_edit"
  patch "/users/:id/update" => "users#update", as: "user_update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
end
