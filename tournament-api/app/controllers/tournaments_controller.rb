class TournamentsController < ApplicationController
  def index
  end

  def import
    message  = "Successfully imported the CSV file"
    csv_file = params[:file].try(:content_type) == "text/csv"
    message  = "Please choose an CSV file import" unless csv_file
    Tournament.import(params[:file])
    redirect_to root_url, notice: message
  end
end
