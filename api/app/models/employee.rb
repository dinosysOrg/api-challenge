class Employee < ApplicationRecord
	# validates :name, uniqueness: true
	has_many :expenses
end
