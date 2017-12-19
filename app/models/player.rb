class Player < ApplicationRecord
	belongs_to :group
	before_create :create_score
	validates :name, presence: true
	has_many :matches

	def create_score
		self.score ||= 0
	end
end
