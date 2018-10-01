Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'csv/import'
      get 'match/get_list'
      get 'user/player_results'
    end
  end
end
