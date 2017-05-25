class RenameDataColumnToExpence < ActiveRecord::Migration[5.1]
  def change
  	rename_column :expenses, :data, :date
  end
end
