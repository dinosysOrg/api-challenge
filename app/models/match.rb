class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :group
  belongs_to :venue
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
end
