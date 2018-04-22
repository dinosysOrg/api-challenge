class RenameWinnerInResults < ActiveRecord::Migration[5.1]
  def change
    rename_column :results, :winner_id, :player_id
  end
end
