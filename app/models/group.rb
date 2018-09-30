class Group < ApplicationRecord
  has_many :matchs

  validates :name, presence: true
  validates :venue, presence: true
  validates :match_code, presence: true
end
