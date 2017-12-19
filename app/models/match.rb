class Match < ApplicationRecord
	belongs_to :tournament
	belongs_to :group
	belongs_to :venue
end
