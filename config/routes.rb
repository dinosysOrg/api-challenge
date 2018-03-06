
Rails.application.routes.draw do

  post 'import_csv', to: 'tournaments#import_csv'
  get 'cal_points_by_player_and_tournament', to: 'players#cal_points'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
