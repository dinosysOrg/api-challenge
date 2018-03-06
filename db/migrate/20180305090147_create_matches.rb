class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.date :date
      t.time :time
      t.string :match_code
      t.integer :venue_id, index: true
      t.integer :player_1_id, index: true
      t.integer :player_2_id, index: true
      t.integer :group_id, index: true

      t.timestamps
    end
  end
end
