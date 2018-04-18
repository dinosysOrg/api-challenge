class Result < ApplicationRecord
  has_one :player, foreign_key: "winner_id"
  belongs_to :match
end
