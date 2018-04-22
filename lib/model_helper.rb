module ModelHelper
  extend self
    def csv? filename, sep = ";"
      return false unless File.exist? filename
      content = File.read filename, encoding: "utf-8"
      return false unless content.valid_encoding?

      CSV.parse(content, col_sep: sep)
    end

    def count_point score, player_1, player_2
      if score.include? Result::GAVE_UP
        count_point_when_give_up score, player_1, player_2
      else
        count_point_when_not_give_up score
      end
    end

    def count_point_when_not_give_up score
      player_1_score, player_2_score = score.split("-").map(&:to_i)
      if player_1_score > player_2_score
        [{score: player_1_score, point: Result::POINTS[:win]}, {
          score: player_2_score, point: Result::POINTS[:lose]
        }]
      elsif player_1_score < player_2_score
        [{score: player_1_score, point: Result::POINTS[:lose]}, {
          score: player_2_score, point: Result::POINTS[:win]
        }]
      else
        [{score: player_1_score, point: Result::POINTS[:draw]}, {
          score: player_2_score, point: Result::POINTS[:draw]
        }]
      end
    end

    def count_point_when_give_up score, player_1, player_2
      if score.include? player_1.name
        [{score: nil, point: Result::POINTS[:lose]}, {
          score: nil, point: Result::POINTS[:win]
        }]
      elsif score.include? player_2.name
        [{score: nil, point: Result::POINTS[:win]}, {
          score: nil, point: Result::POINTS[:lose]
        }]
      end
    end
end
