class Player < ApplicationRecord
  belongs_to :group
  has_many :results, dependent: :destroy
  has_many :matches, through: :results
end
