module Api
  class TournamentResponseService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def get_matches
      matches  = []
      response = []

      matches =
        Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          if tournament_name = params[:tournament]
            tournament = Tournament.find_by_name(tournament_name)
            matches    = tournament.matches if tournament
          end

          if player_name = params[:player]
            player  = Player.find_by_name(player_name)
            matches = player.matches if player
          end

          matches
        end

      response =
        Rails.cache.fetch("matches_response_#{cache_key}", expires_in: 10.minutes) do
          matches.includes(:group, :players).map do |match|
            {
              group:   match.group.name,
              name:    match.name,
              date:    match.date.strftime("%a, %d %b %Y"),
              time:    match.time,
              venue:   match.venue,
              players: match.players.pluck(:name)
            }
          end
        end if matches.present?

      response
    end

    def get_statistical
      response = {}
      response =
        Rails.cache.fetch("statistical_response_#{cache_key}", expires_in: 10.minutes) do
          if player = Player.find_by_name(params[:player])
            response =
              {
                points: player.take_place_matches.sum(:point)
              }

            won, lost, drawn = Array.new(3){0}
            player.matches.includes(:take_place_matches).each do |match|
              points =
                match.take_place_matches.pluck(:player_id, :point).to_h
              player_points, opponent_points = [points.delete(player.id), points.values[0]]
              case
              when player_points > opponent_points
                won += 1
              when player_points < opponent_points
                lost += 1
              else
                drawn += 1
              end
            end # end iterate over matches

            response[:won], response[:lost], response[:drawn] = [won, lost, drawn]
            response
          end
        end

      response
    end

    private
      def cache_key
        params.values.map(&:parameterize).join("-")
      end
  end
end