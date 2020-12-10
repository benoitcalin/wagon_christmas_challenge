class CreateBatchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :batch_results do |t|
      t.integer :score
      t.string :best_end_time
      t.references :batch, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
