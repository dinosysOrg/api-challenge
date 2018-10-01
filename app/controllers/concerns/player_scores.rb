module PlayerScores
  def player_scores(user)
    @points, @won, @drawn, @lost = 0, 0, 0, 0
    @user = user

    _matchs = Match.where("player_1_id = ? OR player_2_id = ?", user, user)
    _matchs.each do |_match|
      player_points_of_a_match(_match)
    end
    return {
        points: @points,
        matchs_result: {
          won: @won,
          drawn: @drawn,
          lost: @lost,
        }
      }
  end

  private
    def player_points_of_a_match(_match)
      if _match.score.scan("gave up").present?
        ponits_when_gave_up(_match)
      else
        point_when_no_gave_up(_match)
      end
    end

    def ponits_when_gave_up(_match)
      username = _match.score.split(" gave up").first
      if username != @user.name
        @won += 1
        @points += 3
      else
        @lost += 1
      end
    end

    def point_when_no_gave_up(_match)
      score_arr = _match.score.split("-")
      if score_arr[0]  == score_arr[1]
        @drawn += 1
        @points += 1
      elsif (@user.id == _match.player_1_id && score_arr[0] > score_arr[1]) || \
            (@user.id == _match.player_2_id && score_arr[0] < score_arr[1])
          @points += 3
          @won += 1
      else
        @lost += 1
      end
    end
end