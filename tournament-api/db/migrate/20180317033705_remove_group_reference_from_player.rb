class RemoveGroupReferenceFromPlayer < ActiveRecord::Migration[5.0]
  def up
    remove_reference :players, :group, index: true
  end

  def down
    add_reference :players, :group, index: true
  end
end
