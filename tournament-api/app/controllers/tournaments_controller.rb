class TournamentsController < ApplicationController
  def index
  end

  def import
    message = "Successfully imported the CSV file"
    message =
      params[:file].try(:content_type) != "text/csv" &&
      "Please choose an CSV file import"
    Tournament.import(params[:file])
    redirect_to root_url, notice: message
  end
end
