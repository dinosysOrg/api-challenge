class AddGroupToMatch < ActiveRecord::Migration[5.1]
  def change
    add_reference :matches, :group, foreign_key: true
  end
end
