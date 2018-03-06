class Group < ApplicationRecord
  has_many :matches
  belongs_to :tournament
end
