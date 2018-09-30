module PlayerScores
  def player_scores(user_id)
    _matchs = Match.where("player_1_id = ? OR player_2_id = ?", user_id, user_id)
    @user = User.find(user_id)
    @user_scores = 0
    _matchs.each do |_match|
      player_points_of_a_match(_match)
    end
    @user_scores
  end

  private
    def player_points_of_a_match(_match)
      if _match.score.scan("gave up").present?
        @user_scores += calc_when_gave_up(_match)
      else
        @user_scores += calc_score_of_match(_match)
      end
    end

    def ponits_when_gave_up(_match)
      username = _match.score.split(" gave up").first
      username != @user.name ? 3 : 0
    end

    def point_when_no_gave_up(_match)
      score_arr = _match.score.split("-")
      # draw match
      if score_arr[0]  == score_arr[1]
        return 1
      end
      # Wining or losing
      if @user.id == _match.player_1_id
        return score_arr[0] > score_arr[1] ? 3 : 0
      elsif @user.id == _match.player_2_id
        return score_arr[0] > score_arr[1] ? 0 : 3
      end
    end
end