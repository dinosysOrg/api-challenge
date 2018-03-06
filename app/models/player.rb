class Player < ApplicationRecord
  def cal_point(tournament_id)
    result = self.class.connection.exec_query <<-SQL
      SELECT sum(
        case when m.win then m2.winner_point
          when m.draw then m2.drawer_point
          when m.loose then m2.looser_point
          else 0
        end
      ) as total_points
      FROM match_records m
      join match_rules m2 ON m.match_rule_id = m2.id
      join matches ma on ma.id = m.match_id
      join groups g on g.id = ma.group_id
      join tournaments t on t.id = g.tournament_id
      where player_id = #{id} and t.id = #{tournament_id}
    SQL
    result.to_a.first['total_points']
  end

  def filter_matches(tournament_id = nil)
    if tournament_id
      Match.joins('join groups g on g.id = matches.group_id').where("(player_1_id = #{id} or player_2_id = #{id}) and tournament_id = #{tournament_id}")
    else
      Match.where("player_1_id = #{id} or player_2_id = #{id}")
    end
  end
end
