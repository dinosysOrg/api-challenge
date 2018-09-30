class Api::V1::MatchController < ApplicationController
  before_action :load_matchs, only: :get_list
  def get_list
    match_serializer = parse_json @matchs
    json_response "#{@matchs.size} matchs have been found", true, match_serializer, :ok
  end

  private
    def load_matchs
      search_str = params[:search_string]

      # If search string match with username
      user =  User.find_by_name(search_str)
      return search_by_username(user) if user

      # If search string match with tournament
      tournament = Tournament.find_by_name(search_str)
      return search_by_tournament(tournament) if tournament

      json_response "Cann't find any username or tournament matching with '#{search_str}'", false, {}, :not_found
    end

    def search_by_tournament(tournament)
      @matchs = tournament.matchs.includes(:venue, :group, :player_1, :player_2)
    end

    def search_by_username(user)
      @matchs = Match.where("player_1_id = ? OR player_2_id = ?", user, user)
      @matchs.includes(:venue, :group, :player_1, :player_2)
    end
end
