class MatchesController < ApplicationController
  def index
  	@matches = Match.order("created_at DESC")
  end

  def new
  	@match = Match.new
  end

  def create
  	@match = Match.new(match_params)
  	if @match.save
      redirect_to matches_path
    else
      render :json => {status: "failed", message: @match.errors}
    end
  end

  def update
  	@match = Match.find(params[:id])
  	if @match.update_column(params[:name], params[:value])
  		render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
  	end
  end

  def destroy
  	@match = Match.find(params[:id])
  	if @match.destroy
  		render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
  	end
  end

  private
  def match_params
  	params.require(:match).permit(:name, :tournament_id, :player_id1, :player_id2, :time , :date, :venue_id, :result, :group_id)
  end
end
