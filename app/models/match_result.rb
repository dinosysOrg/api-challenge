class MatchResult < ApplicationRecord
  belongs_to :match
  belongs_to :match_rule
  belongs_to :player, foreign_key: :gave_up_player_id
end
