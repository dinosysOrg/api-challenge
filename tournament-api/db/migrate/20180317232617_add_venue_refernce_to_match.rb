class AddVenueRefernceToMatch < ActiveRecord::Migration[5.0]
  def up
    remove_column :matches, :venue
    add_reference :matches, :venue, index: true
  end

  def down
    add_column :matches, :venue, :string, null: false, limit: 100
    remove_reference :matches, :venue, index: true
  end
end
