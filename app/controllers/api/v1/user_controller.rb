class Api::V1::UserController < ApplicationController
  include PlayerScores
  before_action :load_user

  def player_results
    player_rs_serializer = parse_json player_scores(@user)
    json_response "Successfully", true, player_rs_serializer, :ok
  end

  private
    def load_user
      @user = User.find_by_name(params[:username])
      unless @user
        json_response "Cann't find any username matching with '#{params[:username]}", false, {}, :not_found
      end
    end

end


# search by user_name
# {
#   points: 9,
#   match_result: {
#     won: ,
#     lost:,
#     drawn:
#   }
# }

# search by player name or tournament name.
# [
#   {
#     group
#     match_code
#     p1
#     p2
#     venue
#     score
#     time
#     date
#   }
# ]