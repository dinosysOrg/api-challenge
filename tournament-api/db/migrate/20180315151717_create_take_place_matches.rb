class CreateTakePlaceMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :take_place_matches do |t|
      t.references :player, index: true
      t.references :match, index: true

      t.timestamps
    end
  end
end
