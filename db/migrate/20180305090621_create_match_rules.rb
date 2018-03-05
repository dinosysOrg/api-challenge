class CreateMatchRules < ActiveRecord::Migration[5.1]
  def change
    create_table :match_rules do |t|
      t.string :name, index: true
      t.integer :winner_point
      t.integer :looser_point
      t.integer :drawer_point
      t.boolean :is_knockout

      t.timestamps
    end
  end
end
