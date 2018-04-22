class Match < ApplicationRecord
  MATCH_ATRRIBUTES = %w(code date time venue).freeze

  has_many :results, dependent: :destroy
  has_many :players, through: :results

  belongs_to :group
  belongs_to :tournament

  scope :by_player_name, ->(player_name){where player_id: Player.by_player_name(player_name)}

  class << self
    def search player_1_id, player_2_id
      (joins(:players).merge(Player.where(id: player_1_id)) &
        joins(:players).merge(Player.where(id: player_2_id))).first
    end

    def by_tournament_name tournament_name
      includes(:tournament).where tournaments:{name: tournament_name}
    end
  end
end
