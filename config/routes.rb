Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      post "expenses/import" => "expenses#import", as: "expenses_import"  
      get "expenses/total_expense_by_category" => "expenses#total_expense_by_category"
    end
  end
end
