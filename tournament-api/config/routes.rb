Rails.application.routes.draw do
  resources :tournaments do
    collection { post :import }
  end

  root to: "tournaments#index"
end
