Rails.application.routes.draw do
 	resources :groups, except: [:show, :update]
  post "update_group", to: "groups#update"
  post "destroy_group", to: "groups#destroy"


  resources :venues , except: [:show, :destroy, :update, :edit]
  post "destroy_venue", to: "venues#destroy"
  post "update_venue", to: "venues#update"


  resources :tournaments, except: [:destroy, :update]
  post "destroy_tournament", to: "tournaments#destroy"
  post "update_tournament", to: "tournaments#update"
end
