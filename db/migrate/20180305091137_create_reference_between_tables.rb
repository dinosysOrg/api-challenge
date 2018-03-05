class CreateReferenceBetweenTables < ActiveRecord::Migration[5.1]
  def change
    # for groups
    add_foreign_key :groups, :tournaments, column: :tournament_id

    # for matches
    add_foreign_key :matches, :venues, column: :venue_id
    add_foreign_key :matches, :players, column: :player_1_id
    add_foreign_key :matches, :players, column: :player_2_id
    add_foreign_key :matches, :groups, column: :group_id
    # for match results
    add_foreign_key :match_results, :match_rules, column: :match_rule_id
    add_foreign_key :match_results, :players, column: :gave_up_player_id
  end
end
