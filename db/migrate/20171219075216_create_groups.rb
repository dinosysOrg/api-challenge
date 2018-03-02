class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :tournament_id
      
      t.timestamps
    end
  end
end
