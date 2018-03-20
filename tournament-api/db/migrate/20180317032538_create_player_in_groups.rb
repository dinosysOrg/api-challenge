class CreatePlayerInGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :player_in_groups do |t|
      t.references :player, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
