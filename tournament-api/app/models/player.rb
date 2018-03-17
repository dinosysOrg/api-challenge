class Player < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  belongs_to :group
  has_many :take_place_matches, dependent: :destroy
  has_many :matches, through: :take_place_matches
end
