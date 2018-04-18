class Match < ApplicationRecord
  belongs_to :player_1, class_name: "Player", foreign_key: "player_1_id", inverse_of: "Player"
  belongs_to :player_2, class_name: "Player", foreign_key: "player_2_id", inverse_of: "Player"
  belongs_to :group
end
