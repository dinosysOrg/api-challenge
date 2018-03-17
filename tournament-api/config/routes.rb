Rails.application.routes.draw do
  resources :tournaments, only: [:index] do
    collection { post :import }
  end

  root to: "tournaments#index"
end
