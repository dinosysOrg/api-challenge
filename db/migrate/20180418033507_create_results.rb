class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.references :winner, index: true, foreign_key: {to_table: :players}
      t.references :match, foreign_key: true
      t.timestamps
    end
  end
end
