class User < ApplicationRecord
  has_many :player_1s, class_name: "Match", foreign_key: "player_1_id", dependent: :destroy
  has_many :player_2s, class_name: "Match", foreign_key: "player_2_id", dependent: :destroy

  validates :name, presence: true
end
