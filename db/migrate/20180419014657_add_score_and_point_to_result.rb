class AddScoreAndPointToResult < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :score, :integer
    add_column :results, :point, :integer
  end
end
