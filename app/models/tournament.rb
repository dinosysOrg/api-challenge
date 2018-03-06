class Tournament < ApplicationRecord
  has_many :groups
  has_many :matches, through: :groups

  def statistic(tournament_id)
    result = self.class.connection.exec_query <<-SQL
      SELECT p.id, p.name, sum(
          case when m.win then m2.winner_point
            when m.draw then m2.drawer_point
            when m.loose then m2.looser_point
            else 0
          end
        ) as total_points,
        count(nullif(m.win,false)) as wins,
        count(nullif(m.loose,false)) as looses,
        count(nullif(m.draw,false)) as draws

      FROM players p
      left join match_records m on m.player_id = p.id
      left join match_rules m2 ON m.match_rule_id = m2.id
      left join matches ma on ma.id = m.match_id
      left join groups g on g.id = ma.group_id
      left join tournaments t on t.id = g.tournament_id
      where t.id = #{tournament_id}
      group by p.id, p.name
      order by sum(
        case when m.win then m2.winner_point
          when m.draw then m2.drawer_point
          when m.loose then m2.looser_point
          else 0
        end
      ) desc
    SQL
    result.to_a
  end
end
