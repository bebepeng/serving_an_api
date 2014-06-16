Rails.application.routes.draw do
  resources :makes, only: [:index, :show]
  resources :cars
end
