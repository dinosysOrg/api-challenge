class Venue < ApplicationRecord
  has_many :matchs

  validates :name, presence: true
end
