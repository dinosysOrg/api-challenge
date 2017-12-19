class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :name
      t.integer :tournament_id
      t.integer :player_id1
      t.integer :player_id2
      t.time :time
      t.date :date
      t.integer :venue_id
      t.string :result
      t.timestamps
    end
  end
end
