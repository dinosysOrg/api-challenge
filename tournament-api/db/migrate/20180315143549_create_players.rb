class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name, null: false, limit: 100
      t.references :group, index: true
      t.timestamps
    end

    add_index :players, :name
  end
end
