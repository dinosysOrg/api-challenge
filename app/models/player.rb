class Player < ApplicationRecord
  belongs_to :group
  has_many :matches, dependent: :destroy
  has_many :results, through: :matches
end
