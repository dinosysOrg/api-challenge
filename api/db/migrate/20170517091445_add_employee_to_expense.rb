class AddEmployeeToExpense < ActiveRecord::Migration[5.1]
  def change
    add_reference :expenses, :employee, foreign_key: true
  end
end
