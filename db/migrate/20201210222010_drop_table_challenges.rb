class DropTableChallenges < ActiveRecord::Migration[6.0]
  def change
    drop_table :challenges
  end
end
