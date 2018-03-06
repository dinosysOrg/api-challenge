class CreateReferenceBetweenTables < ActiveRecord::Migration[5.1]
  def change
    # for groups
    add_foreign_key :groups, :tournaments, column: :tournament_id

    # for matches
    add_foreign_key :matches, :venues, column: :venue_id
    add_foreign_key :matches, :players, column: :player_1_id
    add_foreign_key :matches, :players, column: :player_2_id
    add_foreign_key :matches, :groups, column: :group_id
    add_foreign_key :matches, :players, column: :gave_up_player_id
  end
end
