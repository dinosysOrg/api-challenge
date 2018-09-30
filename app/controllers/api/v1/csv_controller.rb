class Api::V1::CsvController < ApplicationController
  require "csv"
  before_action :csv_params, only: :import
  before_action :detect_csv, only: :import

  def import
    begin
      handle_import_csv
      json_response "Import #{tournament_name} successfully", true, {}, :ok
    rescue Exception => e
      json_response "Error: #{e}", false, {}, :internal_server_error
    end
  end

  private
    def csv_params
      params.require(:csv).permit(:file)
    end

    def tournament_name
      csv_params[:file].original_filename.split(".csv").first
    end

    def detect_csv
      content_type = csv_params[:file].content_type
      if content_type != "text/csv"
        json_response "Input wrong, File type should be csv", false, {}, :unsupported_media_type
      end
    end

    def handle_import_csv
      _group , _venue , _match = nil, nil, nil
      tournament = Tournament.find_or_create_by(name: tournament_name)
      CSV.foreach(csv_params[:file].path, headers: true) do |row|
        if row["id"]
          _group = Group.find_or_create_by(name: row["group"])
          _venue = Venue.find_or_create_by(name: row["venue"])
          # Player
          player_1 = User.find_or_create_by(name: row["player 1"])
          player_2 = User.find_or_create_by(name: row["player 2"])
          # Match
          _match = _group.matchs.where(venue: _venue)
                                .where(match_code: row["match code"])
          _match.first_or_create({
            time: row["time"], date: row["date"],
            match_code: row["match code"],
            tournament_id: tournament.id,
            player_1_id: player_1.id, player_2_id: player_2.id,
            score: row["score"], venue: _venue
          })
        end
      end
    end

    # def model_errors(obj)
    #   return if obj.blank?
    #   if obj.errors.messages.present?
    #     json_response "Error: #{obj.errors.messages}", false, {}, :ok
    #   else
    #     json_response "Input wrong at #{obj.class.name}", false, {}, :ok
    #   end
    # end

end
