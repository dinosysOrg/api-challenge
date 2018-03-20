class ChangeTimeColumnTypeOnMatch < ActiveRecord::Migration[5.0]
  def up
    change_column :matches, :time, :string, limit: 20
  end

  def down
    change_column :matches, :time, :time
  end
end
