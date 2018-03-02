class Venue < ApplicationRecord
	validates :name , presence: true
	validates :name, uniqueness: true
	has_many :matches, dependent: :destroy
end
