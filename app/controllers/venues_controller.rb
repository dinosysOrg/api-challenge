class VenuesController < ApplicationController
  before_action :set_venue , only: [:destroy, :edit]
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to venues_path
    else
      render :json => {status: "failed", message: @venue.errors}
    end
  end

  def destroy
    if @venue.destroy
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  def edit
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update_column(params[:name], params[:value])
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  private
  def venue_params
    params.require(:venue).permit(:name)
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end
end
