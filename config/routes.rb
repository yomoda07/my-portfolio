Rails.application.routes.draw do
  resources :topics, only: [:show]

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end

  get 'angular-items', to:'portfolios#angular'
  get 'portfolio/:id', to:'portfolios#show',as:'portfolio_show'
  get 'tech-news', to: 'pages#tech_news'
  post 'inquiries', to:'pages#inquiry'

  resources :blogs do
    member do
      get :toggle_status
    end
  end

  mount ActionCable.server => '/cable'

  root to: 'pages#home'
end

