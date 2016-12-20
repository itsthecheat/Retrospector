Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  # get 'sessions/login_attempt'

  # get 'sessions/home'

  # get 'sessions/profile'

  # get 'sessions/setting'

  # root :to => "sessions#login"
  # get "signup", :to => "users#new"
  # get "login", :to => "sessions#login"
  # get "logout", :to => "sessions#logout"
  # get "home", :to => "sessions#home"
  # get "profile", :to => "sessions#profile"
  # get "setting", :to => "sessions#setting"

  root :to => "sessions#home"
  get "signup", :to => "users#new"
  get "login", :to => "sessions#login"
  post "login_attempt", :to => "sessions#login_attempt"
  get "logout", :to => "sessions#logout"
  get "home", :to => "sessions#home"
  get "profile", :to => "sessions#profile"
  get "setting", :to => "sessions#setting"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "reviews#index"
  #I guess this is making a route for email confirmation?
  resources :users do
    member do
      get :confirm_email
    end
  end

  resources :reviews
  resources :password_resets, only: [:new, :create, :edit, :update]
  
end
