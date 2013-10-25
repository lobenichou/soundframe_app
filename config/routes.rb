SoundframeApp::Application.routes.draw do

  root to: "home#index"

  resources :tracks

end
