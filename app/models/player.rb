class Player < ApplicationRecord
	extend FriendlyId
  friendly_id :name , use: [:slugged, :finders]
  
	belongs_to :group
	has_many :matches
	
	after_create :create_score
	after_destroy :delete_relation_matches
	validates :name, presence: true
	validates :name, uniqueness: {scope: :group_id}

	def create_score
		self.score ||= 0
		self.win ||= 0
		self.lose ||= 0
		self.draw ||= 0
	end

	def delete_relation_matches
		matches = Match.where(player_id1: self.id).or(Match.where(player_id2: self.id))
		matches.destroy_all
	end
end
