Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do
      resources :expenses, only: :create
      get 'calc_pre_tax' => 'expenses#total_pre_tax_by_category'
      get 'calc_tax' => 'expenses#total_tax_by_category'
      get 'calc_expenses' => 'expenses#total_expenses_by_category'
    end
  end

end
