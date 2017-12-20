class PlayersController < ApplicationController
  def index
    @players = Player.order("score DESC").includes(:group)
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_path
    else
      render :json => {status: "failed", message: @player.errors}
    end
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_column(params[:name], params[:value])
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @matches = Match.where(player_id1: @player.id).or(Match.where(player_id2: @player.id))
    if @player.destroy
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :score, :group_id)  
  end

end