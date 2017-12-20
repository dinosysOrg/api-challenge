class Group < ApplicationRecord
	belongs_to :tournament
	has_many :players
	validates :name, presence: true
	validates :name, uniqueness: true
	validates :tournament_id, presence: true
end
