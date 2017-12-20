class AddInfoToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :win, :integer
    add_column :players, :draw, :integer
    add_column :players, :lose, :integer
  end
end
