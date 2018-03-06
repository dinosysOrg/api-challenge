
Rails.application.routes.draw do

  post 'import_csv', to: 'tournaments#import_csv'
  get 'player/statistic', to: 'players#statistic'
  get 'filter_matches', to: 'matches#filter_matches'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
