class RemovePlayerFromMatch < ActiveRecord::Migration[5.1]
  def change
    remove_column :matches, :player_1_id, :integer
    remove_column :matches, :player_2_id, :integer
  end
end
