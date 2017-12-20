class Tournament < ApplicationRecord
	has_many :groups , dependent: :destroy
	extend FriendlyId
  friendly_id :name , use: [:slugged, :finders]
	
	validates :name, uniqueness: true
	validates :name , presence: true
end
