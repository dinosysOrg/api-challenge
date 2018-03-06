class PlayersController < ApplicationController

  def cal_points
    player = Player.find_by_name(params[:player_name])
    unless player
      render json: { success: false, error: 'Player name is invalid' }
      return
    end
    tournament = Tournament.find_by_name(params[:tournament_name])
    unless tournament
      render json: { success: false, error: 'Tournament name is invalid' }
      return
    end
    render json: { success: true, points: player.cal_point(tournament.id) }

  end
end
