Rails.application.routes.draw do
  resources :tournaments, only: [:index] do
    collection { post :import }
  end

  namespace :api do
    get "matches", to: "tournaments#get_matches"
  end

  root to: "tournaments#index"
end
