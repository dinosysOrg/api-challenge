class Expense < ApplicationRecord
	validates_uniqueness_of :category, scope: [:date, :expense_description,
						:tax_name, :pre_tax_amount, :tax_amount] 
	belongs_to :employee
end
