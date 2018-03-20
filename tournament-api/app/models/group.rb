class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  belongs_to :tournament
  has_many :matches, dependent: :destroy, inverse_of: :group
  has_many :player_in_groups, dependent: :destroy
  has_many :players, through: :player_in_groups
end
