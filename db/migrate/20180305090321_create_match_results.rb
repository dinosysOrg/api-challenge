class CreateMatchResults < ActiveRecord::Migration[5.1]
  def change
    create_table :match_results do |t|
      t.integer :match_id, index: true
      t.integer :player_1_goals
      t.integer :player_2_goals
      t.integer :gave_up_player_id, index: true
      t.integer :match_rule_id, index: true

      t.timestamps
    end
  end
end
