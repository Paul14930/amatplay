Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/create'
  get 'clubs/index'
  get 'clubs/show'
  get 'clubs/new'
  get 'clubs/create'
  get 'clubs/edit'
  get 'clubs/update'
  get 'clubs/destroy'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 get 'cameras/show', to: 'cameras#show'
 get 'cameras/stream', to: 'cameras#stream'
  # Defines the root path route ("/")
 root 'home#index'
 resources :clubs do
  # Gestion des caméras associées à un club
  resources :cameras, only: [:show, :new, :create, :destroy] do
    member do
      post :start_recording
      post :stop_recording
    end

    # Gestion des enregistrements programmés pour une caméra
    resources :scheduled_recordings, only: [:create]
  end
end



  # Ressources liées aux events
  resources :events, only: [:index, :show, :new, :create]
end
