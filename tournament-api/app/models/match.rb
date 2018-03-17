class Match < ApplicationRecord
  validates :name, :time, :date, :venue, :score, presence: true
  validates :name, length: { maximum: 50 }
  validates :venue, :score, length: { maximum: 100 }
  validates :time, length: { maximum: 20 }
  belongs_to :group
  has_many :take_place_matches, dependent: :destroy
  has_many :players, through: :take_place_matches

  ASSIGNABLE_ATRRIBUTES =
    [
      "time",
      "date",
      "venue",
      "score"
    ].freeze
  GAVE_UP = "gave up".freeze
  POINTS =
    {
      give_up: 3,
      win: 3,
      draw: 1
    }.freeze

  def calc_player_point
    if self.score.include?(GAVE_UP)
      gave_up_player_name = self.score.gsub(GAVE_UP, "").strip
      opponent = players.find{ |player| player.name != gave_up_player_name }
      take_place_match =
        take_place_matches.find{ |take_place_match|
          take_place_match.player_id == opponent.id
        }
      take_place_match.update!(point: POINTS[:give_up])
    else
      first_player_point, second_player_point = self.score.split("-").map(&:to_i)
      two_players_are_draw = false

      case
      when first_player_point > second_player_point
        winer, loser = players
      when first_player_point < second_player_point
        winer, loser = players.reverse
      else
        take_place_matches.update_all(point: POINTS[:draw])
        two_players_are_draw = true
      end

      take_place_matches.find{ |take_place_match|
        take_place_match.player_id == winer.id
      }.update!(point: POINTS[:win]) unless two_players_are_draw
    end
  end
end
