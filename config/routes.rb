Rails.application.routes.draw do
  devise_for :users
  root "characters#index"

  resources :characters
end
