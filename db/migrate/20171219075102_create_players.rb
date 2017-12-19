class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :score
      t.integer :group_id

      t.timestamps
    end
  end
end
