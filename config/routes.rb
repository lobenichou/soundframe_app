SoundframeApp::Application.routes.draw do

  root to: "home#index"

  resources :tracks, :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :projects do
    put 'add_image_to_track', :on => :member
    get 'update_map_region', :on => :member
    put 'change_map_region', :on => :member
    get 'update_track_location', :on => :member
    delete 'remove_track', :on => :member
    delete 'remove_image', :on => :member
  end

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signup', to: 'users#new',  via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/about', to: 'home#about', via: 'get'
  match '/help', to: 'home#help', via: 'get'

end
