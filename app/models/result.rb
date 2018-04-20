class Result < ApplicationRecord
  belongs_to :player
  belongs_to :match

  GAVE_UP = "gave up".freeze
  POINTS = {
    lose: 3,
    win: 3,
    draw: 1
  }.freeze
end
