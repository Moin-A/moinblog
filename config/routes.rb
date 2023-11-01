

Rails.application.routes.draw do
  resources :posts do
    collection do
      get "all_post" => "posts#all_post"
      get "featured" => "posts#featured"
      get "trending" => "posts#trending"
      get "news" => "posts#news"
      get "events" => "posts#events"
      get "latest" => "posts#latest"
      get "tech" => "posts#tech"
  end  
end
resources :posts do
  resources :comments, only: [:edit, :update, :show, :destroy, :create]
  get 'comments/all', on: :member
end  

  require 'sidekiq/web'
  
  mount ActionCable.server => '/cable' 
  mount Sidekiq::Web => '/sidekiq'
  
  get 'private/test'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'users/get_invited_user', to: 'users#get_invited_user'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    root to: 'users/sessions#new'
    resources :users  do
      collection do
        get "authenticate" => "users/sessions#authenticate_user"
    end
  end     
  end
 
  resources :member_details

end
