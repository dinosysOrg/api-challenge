require 'csv'

class Tournament < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  has_many :groups, dependent: :destroy, inverse_of: :tournament
  has_many :matches, through: :groups,  dependent: :destroy

  class << self
    attr_reader :tournament, :attributes
    attr_reader :group, :match
    PLAYER_HEADER = ["player 1", "player 2"]

    def import(file)
      return unless file
      tournament_name = file.original_filename.gsub(/\..+/, "").capitalize
      @tournament     = Tournament.where(name: tournament_name).first_or_create
      ActiveRecord::Base.transaction do
        CSV.foreach(file.path, headers: true, skip_blanks: true) do |row|
          break unless row[0]
          @attributes = row.to_h
            row_parser
            self.match.calc_player_point
        end # end CSV foreach
      end # end ActiveRecord transaction
    end

    private
      def import_group
        self.tournament
            .groups
            .where(name: self.attributes["group"])
            .first_or_create!
      end

      def import_players
        self.attributes.slice(*PLAYER_HEADER).each do |header, player_name|
          player = self.group.players.where(name: player_name).first_or_create!
          import_take_place_match(player.id)
        end
      end

      def import_match
        match =
          self.group.matches
                    .where(name: self.attributes["match code"])
                    .first_or_initialize
        attributes_to_be_assigned =
          self.attributes.slice(*Match::ASSIGNABLE_ATRRIBUTES)
        match.assign_attributes(attributes_to_be_assigned)
        match.save!
        match
      end

      def import_take_place_match(player_id)
        TakePlaceMatch.where(
          match_id: self.match.id,
          player_id: player_id
        ).first_or_create!
      end

      def row_parser
        @group = import_group
        @match = import_match
        import_players
      end
  end
end