class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :date
      t.integer :category_id
      t.string :employee_name
      t.text :employee_address
      t.text :expense_description
      t.string :pre_tax_amount
      t.string :tax_name
      t.string :tax_amount

      t.timestamps null: false
    end
  end
end
