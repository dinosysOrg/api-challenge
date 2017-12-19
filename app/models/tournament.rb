class Tournament < ApplicationRecord
	has_many :groups , dependent: :destroy
	extend FriendlyId
  friendly_id :name , use: [:slugged, :finders]
	
	validates :name , presence: true
end
