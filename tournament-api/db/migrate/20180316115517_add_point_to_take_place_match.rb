class AddPointToTakePlaceMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :take_place_matches, :point, :integer, default: 0
  end
end
