require "model_helper"
class Tournament < ApplicationRecord
  require "csv"

  has_many :groups, dependent: :destroy
  has_many :matches, through: :groups, dependent: :destroy

  class << self
    PLAYER_ATRRIBUTES = ["player 1", "player 2"].freeze

    def import_tournament_from_csv csv_file
      return unless ModelHelper.csv?(csv_file.path)
      tournament_name = csv_file.original_filename.gsub(/\..+/, "").capitalize
      @tournament = Tournament.where(name: tournament_name).first_or_create

      ActiveRecord::Base.transaction do
        CSV.foreach csv_file.path, headers: true, skip_blanks: true,
                              skip_lines: /^(?:,\s*)+$/ do |row|
          break if row[0].nil? || row.any?(&:blank?)
          @attributes = row.to_h
          row_parser
        end
      end
      @tournament
    rescue StandardError => e
      Rails.logger.error e
      false
    end

    private

    def import_group
      Group.where(name: @attributes["group"], tournament_id: @tournament.id)
        .first_or_create!
    end

    def import_players
      @attributes.slice(*PLAYER_ATRRIBUTES).each_value do |player_name|
        Player.where(name: player_name, group_id: @group.id).first_or_create!
      end
      Player.where name: @attributes.slice(*PLAYER_ATRRIBUTES).values
    end

    def import_match
      match = Match
        .where(code: @attributes["match code"],
               group_id: @group.id,
               tournament_id: @tournament.id)
        .first_or_initialize
      match_assign_attributes = @attributes.slice(*Match::MATCH_ATRRIBUTES)
      match.assign_attributes match_assign_attributes
      match.save!
      match
    end

    def import_result
      player_1_result, player_2_result = ModelHelper
        .count_point(@attributes["score"], @players[0], @players[1])

      result1 = Result.where(player_id: @players[0].id, match_id: @match.id).first_or_initialize
      result1.assign_attributes score: player_1_result[:score], point: player_1_result[:point]
      result1.save!

      result2 = Result.where(player_id: @players[1].id, match_id: @match.id).first_or_initialize
      result2.assign_attributes score: player_2_result[:score], point: player_2_result[:point]
      result2.save!
    end

    def row_parser
      @group = import_group
      @players = import_players
      @match = import_match
      import_result
    end
  end
end
