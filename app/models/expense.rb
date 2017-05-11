class Expense < ApplicationRecord
  belongs_to :employee
  belongs_to :category

end
