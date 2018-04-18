class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :code
      t.integer :player_1_id
      t.integer :player_2_id
      t.time :time
      t.date :date
      t.string :venue
      t.timestamps
    end
  end
end
