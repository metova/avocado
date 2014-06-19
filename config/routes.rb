Avocado::Engine.routes.draw do
  root to: 'specs#index'
  resources :specs, only: [:create]
end
