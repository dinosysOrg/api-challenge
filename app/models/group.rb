class Group < ApplicationRecord
	belongs_to :tournament
	has_many :players, dependent: :destroy
	validates :name, presence: true
	validates :name, uniqueness: {scope: :tournament_id}
	validates :tournament_id, presence: true
end
