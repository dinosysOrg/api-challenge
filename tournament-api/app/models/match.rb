class Match < ApplicationRecord
  validates :name, :time, :date, :venue, :score, presence: true
  validates :name, length: { maximum: 50 }
  validates :venue, :score, length: { maximum: 100 }
  belongs_to :group
  has_many :take_place_matches
  has_many :players, through: :take_place_matches
end
