class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :pseudo, null: false, default: ""
      t.string :batch, null: false, default: ""
      t.string :challenger_id, null: false, default: ""
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
