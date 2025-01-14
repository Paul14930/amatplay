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
  resources :events, only: [:index, :show, :new, :create]
end

end
