class AddTournamentToGroup < ActiveRecord::Migration[5.1]
  def change
    add_reference :groups, :tournament, foreign_key: true
  end
end
