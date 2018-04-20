class Api::V1::TournamentsController < Api::ApiController
  before_action :load_by_tournament_if_exist, only: :statistical

  def import
    not_csv_file = params[:file].nil? || params[:file].try(:content_type) != "text/csv"
    return api_response "Please import a CSV file", 400 if not_csv_file

    result = Tournament.import_tournament_from_csv(params[:file])
    return api_response "Import failed", 422 unless result

    api_response "Your CSV file has been succesfully imported", 200
  end

  def matches
    if match_params[:tournament_name]
      @matches = Match.by_tournament_name match_params[:tournament_name]
    elsif match_params[:player_name]
      @matches = Match.includes(:players)
        .where(players: {name: match_params[:player_name]})
    else
      return api_response "Your request params is wrong", 400
    end
    return api_response "No result found for your request", 200 if @matches.blank?
    render template: "api/v1/tournaments/match", status: 200
  end

  def statistical
    @result = {}
    @result[:won_matches] = @results.select{|n| n == 3}.size
    @result[:drawn_matches] = @results.select{|n| n == 1}.size
    @result[:lost_matches] = @results.select(&:zero?).size
    @result[:points] = @results.inject(:+)

    render template: "api/v1/tournaments/statistical", status: 200
  end

  private

  def match_params
    params.permit :tournament_name, :player_name
  end

  def statistical_params
    params.permit :player_name, :id
  end

  def load_by_tournament_if_exist
    player_name = statistical_params[:player_name]
    return api_response "Please check your request params", 400 unless player_name
    Result.where(tournament_id: statistical_params[:id])
    @results = if statistical_params[:id]
                 Result.includes(:match).where(matches: {tournament_id: statistical_params[:id]})
                   .by_player_name(player_name).pluck :point
               else
                 Result.by_player_name(player_name).pluck :point
               end
    return api_response "No result found for player: #{player_name}", 200 if @results.blank?
  end
end
