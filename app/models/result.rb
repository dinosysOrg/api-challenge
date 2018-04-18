class Result < ApplicationRecord
  has_one :player, foreign_key: "winner_id", inverse_of: :player, dependent: :destroy
  belongs_to :match
end
