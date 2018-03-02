class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :destroy]
  def index
    @tournaments = Tournament.all
  end

  def show
    @matches = Match.where(tournament_id: @tournament.id)
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to tournaments_path
    else
      render 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_column(params[:name], params[:value])
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  def edit
  end

  def destroy
    if @tournament.destroy
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
