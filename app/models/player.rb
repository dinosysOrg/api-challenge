class Player < ApplicationRecord
  belongs_to :group
  has_many :matches
  has_many :results, through: :matches
end
