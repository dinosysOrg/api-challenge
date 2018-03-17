class Api::TournamentsController < ApplicationController
  def get_matches
    matches  = []
    response = []
    if tournament_name = params[:tournament]
      tournament = Tournament.find_by_name(tournament_name)
      matches    = tournament.matches if tournament
    end

    if player_name = params[:player]
      player  = Player.find_by_name(player_name)
      matches = player.matches if player
    end

    response =
      matches.includes(:group).map do |match|
        {
          group: match.group.name,
          name:  match.name,
          date:  match.date.strftime("%a, %d %b %Y"),
          time:  match.time,
          venue: match.venue,
        }
      end if matches.present?
    render json: response
  end
end
