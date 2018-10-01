class Group < ApplicationRecord
  has_many :matchs

  validates :name, presence: true
end
