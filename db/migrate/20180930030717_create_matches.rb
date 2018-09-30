class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :tournament, foreign_key: true
      t.references :group, foreign_key: true
      t.references :venue, foreign_key: true
      t.integer :player_1_id
      t.integer :player_2_id
      t.string :score
      t.string :match_code
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
