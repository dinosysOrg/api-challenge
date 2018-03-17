class TournamentsController < ApplicationController
  def index
  end

  def import
    message =
      params[:file] &&
      "Successfully imported the CSV file" ||
      "Please choose a file to import"
    Tournament.import(params[:file])
    redirect_to root_url, notice: message
  end
end
