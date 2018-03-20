class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name, null: false, limit: 100

      t.timestamps
    end
  end
end
