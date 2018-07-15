Rails.application.routes.draw do
  devise_for :users
  root to:"stories#index"
  resources :stories do
    member do
      put 'like' => 'stories#like'
      put 'unlike' => 'stories#unlike'
      put 'bookmark' => 'stories#bookmark'
      put 'unbookmark' => 'stories#unbookmark'
    end
    resources :comments
  end
  resources :comments, except: [:index, :new] do
    member do
      put 'like' => 'comments#like'
      put 'unlike' => 'comments#unlike'
      put 'bookmark' => 'comments#bookmark'
      put 'unbookmark' => 'comments#unbookmark'
    end
    resources :comments
  end
  post '/tinymce_assets', to: 'stories#upload_image'
  post '/tinymce_assets', to: 'comments#upload_image'
  get 'about' => 'pages#about'
  get 'support' => 'pages#support'
  get 'privacy' => 'pages#privacy'
  get 'terms' => 'pages#terms'
  get 'tags/:id' => 'pages#tag'
  put ':id/follow' => 'pages#follow', as: :follow_user
  put ':id/unfollow' => 'pages#unfollow', as: :unfollow_user
  get ':id/not_found' => 'pages#missing', as: :missing
  get ':id' => 'pages#profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
