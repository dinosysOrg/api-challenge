Rails.application.routes.draw do

  resources :matches, except: [:show, :destroy, :update, :edit]  
  post "update_matches", to: "matches#update"
  post "destroy_matches", to: "matches#destroy"

  resources :players, except: [:show, :destroy, :update, :edit]  
  post "update_player", to: "players#update"
  post "destroy_player", to: "players#destroy"

 	resources :groups, except: [:show, :destroy, :update, :edit]
  post "update_group", to: "groups#update"
  post "destroy_group", to: "groups#destroy"


  resources :venues , except: [:show, :destroy, :update, :edit]
  post "destroy_venue", to: "venues#destroy"
  post "update_venue", to: "venues#update"


  resources :tournaments, except: [:show, :destroy, :update, :edit]
  post "destroy_tournament", to: "tournaments#destroy"
  post "update_tournament", to: "tournaments#update"
end
