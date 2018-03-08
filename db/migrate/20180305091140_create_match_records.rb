class CreateMatchRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :match_records do |t|
      t.references :match, foreign_key: { to_talbe: :matches }, index: true
      t.references :player, foreign_key: { to_talbe: :players }, index: true
      t.references :match_rule, foreign_key: { to_talbe: :match_rules }, index: true
      t.boolean :win
      t.boolean :loose
      t.boolean :draw

      t.timestamps
    end
  end

end
