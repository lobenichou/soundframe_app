SoundframeApp::Application.routes.draw do

  root to: "home#index"

  resources :tracks, :users

  get "/tracks/:id/:username", :to => 'tracks#show'

  match '/signup', to: 'users#new',  via: 'get'

end
