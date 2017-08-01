Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'

  resources :events

  namespace :admin do
    resources :events do
      member do
        post :publish
        post :hide
      end
    end
  end
end
