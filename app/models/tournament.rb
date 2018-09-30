class Tournament < ApplicationRecord
  has_many :matchs

  validates :name, presence: true
end
