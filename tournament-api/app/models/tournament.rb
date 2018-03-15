class Tournament < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  has_many :groups, dependent: :destroy, inverse_of: :tournament
  has_many :matches, through: :groups,  dependent: :destroy
end
