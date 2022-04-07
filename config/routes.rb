Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
      namespace :revenue do
        resources :items, only: [:index]
      end
      # namespace :most_items do
      #   resources :merchants, only: [:index]
      #   resources :items, only: [:index]
      # end
      get '/merchants/most_items', to: 'most_items#index'
    end
  end
end
