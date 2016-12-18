Rails.application.routes.draw do
  get 'sessions/login,'

  get 'sessions/home,'

  get 'sessions/profile,'

  get 'sessions/setting'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "reviews#index"
  resources :users
  resources :reviews
end
