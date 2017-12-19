class Group < ApplicationRecord
	belongs_to :tournament
	validates :name, presence: true
	validates :tournament_id, presence: true
end
