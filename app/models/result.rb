class Result < ApplicationRecord
  belongs_to :player
  belongs_to :match

  GAVE_UP = "gave up".freeze
  POINTS = {
    lose: 0,
    win: 3,
    draw: 1
  }.freeze

  scope :by_player_name, ->(player_name){includes(:player).where players:{name: player_name}}
end
