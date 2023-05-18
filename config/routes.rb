Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :authentications, only: :create
      namespace :admin do
        namespace :purchases do
          post :search
          post :granularity
        end

        namespace :products do
          get :most_purchased
          get :three_high_profit
        end
      end
    end
  end
end
