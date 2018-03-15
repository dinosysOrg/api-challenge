class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false, limit: 100

      t.timestamps
    end

    add_index :tournaments, :name
  end
end
