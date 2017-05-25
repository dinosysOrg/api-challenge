Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'expenses/import_data'
      get 'expenses/expenses_by_category'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
