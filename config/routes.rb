SoundframeApp::Application.routes.draw do

  get "users/new"

  root to: "home#index"

  resources :tracks

  get "/tracks/:id/:username", :to => 'tracks#show'

end
