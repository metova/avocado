Avocado::Engine.routes.draw do
  post '/', to: 'specs#create'
  root to: 'specs#index'
end
