class Tournament < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :matches, through: :groups, dependent: :destroy
end
