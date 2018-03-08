class MatchRecord < ApplicationRecord
  belongs_to :match
  belongs_to :match_rule
  belongs_to :player
end
