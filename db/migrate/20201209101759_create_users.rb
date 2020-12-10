class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :pseudo, null: false, default: ""
      t.string :challenger_id, null: false, default: ""
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
