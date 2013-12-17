SoundframeApp::Application.routes.draw do

  root to: "home#index"

  resources :tracks, :users, :projects
  resources :sessions, only: [:new, :create, :destroy]

  # get "/tracks/:id/:username", :to => 'tracks#show'

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signup', to: 'users#new',  via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

end
