class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :day, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
