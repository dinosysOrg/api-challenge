class Player < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  has_many :take_place_matches, dependent: :destroy
  has_many :matches, through: :take_place_matches
  has_many :player_in_groups, dependent: :destroy
  has_many :groups, through: :player_in_groups
end
