class Api::TournamentsController < ApplicationController
  before_action :init_response_service

  def get_matches
    response = @response_service.get_matches
    render json: response
  end

  def get_statistical
    response = @response_service.get_statistical
    render json: response
  end

  private
    def init_response_service
      @response_service = Api::TournamentResponseService.new(params)
    end
end
