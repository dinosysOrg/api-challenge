class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :employee_id, index: true
      t.integer :category_id, index: true
      t.text :description
      t.integer :pre_tax_amount
      t.string :tax_name
      t.integer :tax_amount
      t.date :date, index: true

      t.timestamps
    end
  end
end
