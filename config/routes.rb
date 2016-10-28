Avocado::Engine.routes.draw do
  resources :specs, only: [:create]
  root to: 'specs#index'
end
