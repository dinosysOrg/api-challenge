class Venue < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  has_many :matches, dependent: :destroy, inverse_of: :venue
end
