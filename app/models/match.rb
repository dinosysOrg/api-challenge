class Match < ApplicationRecord
  MATCH_ATRRIBUTES = %w(code date time venue).freeze

  has_many :results, dependent: :destroy
  has_many :players, through: :results

  belongs_to :group
  belongs_to :tournament
end
