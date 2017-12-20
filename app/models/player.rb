class Player < ApplicationRecord
	extend FriendlyId
  friendly_id :name , use: [:slugged, :finders]
  
	belongs_to :group
	before_create :create_score
	validates :name, presence: true
	has_many :matches

	def create_score
		self.score ||= 0
		self.win ||= 0
		self.lose ||= 0
		self.draw ||= 0
	end
end
