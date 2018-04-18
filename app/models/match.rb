class Match < ApplicationRecord
  belongs_to :player_1, class_name: "Player", foreign_key: "player_1_id"
  belongs_to :player_2, class_name: "Player", foreign_key: "player_2_id"
  belongs_to :group
end
