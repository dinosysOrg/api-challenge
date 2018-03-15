class TournamentsController < ApplicationController
  def index
  end

  def import
    Tournament.import(params[:file])
    redirect_to root_url, notice: "Tournament has been successfully imported."
  end
end
