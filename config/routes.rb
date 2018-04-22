Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :tournaments, only: %i() do
        collection do
          post :import
          get :matches
          get :statistical
        end
        member do
          get :statistical
        end
      end
    end
  end
end
