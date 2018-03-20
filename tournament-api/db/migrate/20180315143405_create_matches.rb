class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :name, null: false, limit: 50
      t.time :time, null: false
      t.date :date, null: false
      t.string :venue, null: false, limit: 100
      t.string :score, null: false, limit: 100
      t.references :group, index: true

      t.timestamps
    end

    add_index :matches, :name
  end
end
