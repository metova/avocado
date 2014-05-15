Rails.application.routes.draw do
  resources :tests do
    get :json, on: :collection
    get :text, on: :collection
  end
end
