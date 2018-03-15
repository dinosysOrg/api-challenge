class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  belongs_to :tournament
  has_many :players, dependent: :destroy, inverse_of: :group
  has_many :matches, dependent: :destroy, inverse_of: :group
end
