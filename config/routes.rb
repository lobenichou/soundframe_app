SoundframeApp::Application.routes.draw do

  root to: "home#index"

  resources :tracks

  get "/tracks/:id/:username", :to => 'tracks#show'

end
