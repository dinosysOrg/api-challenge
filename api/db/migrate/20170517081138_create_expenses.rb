class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.datetime :data
      t.string :category
      t.decimal :pre_tax_amount, precision: 5, scale: 2
      t.string :expense_description
      t.string :tax_name
      t.decimal :tax_amount, precision: 5, scale: 2

      t.timestamps
    end
  end
end
