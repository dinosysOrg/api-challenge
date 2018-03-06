require 'csv'
class ImportCSVService
  def self.import(tnm) # tnm is tournament file have be saved after upload
    file_path = Rails.root.join(tnm)
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, headers: true)
    tournament_name = tnm.match(/tournament (.*).csv/)[1]
    tournament = Tournament.find_by_name(tournament_name) || Tournament.create(name: tournament_name)
    csv.each do |row|
      # Moulding.create!(row.to_hash)
      row_data = row.to_hash
      next unless row_data['id']
      # create group
      group = Group.find_by_name_and_tournament_id(row_data['group'], tournament.id) || Group.create(name: row_data['group'], tournament_id: tournament.id)
      # create player(football team)
      player1 = Player.find_by_name(row_data['player 1']) || Player.create(name: row_data['player 1'])
      player2 = Player.find_by_name(row_data['player 2']) || Player.create(name: row_data['player 2'])
      # create venue
      venue = Venue.find_by_name( row_data['venue']) || Venue.create(name: row_data['venue'])
      # create match
      match = Match.create(
        match_code: row_data['match code'],
        venue_id: venue.id,
        player_1_id: player1.id,
        player_2_id: player2.id,
        group_id: group.id,
        time:  row_data['time'],
        date: row_data['date']
      )

      match_result = MatchResult.new(match_id: match.id, match_rule_id: MatchRule.find_by_name('round').id)
      goals = row_data['score'].match /(\d+)-(\d+)/
      gave_up_player = row_data['score'].match /(.+) gave up/

      if goals
        match_result.player_1_goals = goals[1]
        match_result.player_2_goals = goals[2]
      elsif gave_up_player == player1.name
        match_result.gave_up_player_id = player1.id
      else
        match_result.gave_up_player_id = player2.id
      end
      match_result.save
    end
  end
end