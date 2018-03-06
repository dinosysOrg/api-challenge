class Match < ApplicationRecord
  belongs_to :group
  belongs_to :venue
  belongs_to :player, foreign_key: :player_1_id
  belongs_to :player, foreign_key: :player_2_id

end
