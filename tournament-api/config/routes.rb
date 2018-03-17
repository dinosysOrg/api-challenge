Rails.application.routes.draw do
  resources :tournaments, only: [:index] do
    collection { post :import }
  end

  namespace :api do
    namespace :v1 do
      get "matches", to: "tournaments#get_matches"
      get "statistical", to: "tournaments#get_statistical"
    end
  end

  root to: "tournaments#index"
end
