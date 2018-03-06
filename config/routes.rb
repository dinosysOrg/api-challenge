
Rails.application.routes.draw do

  post 'import_csv', to: 'tournaments#import_csv'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
