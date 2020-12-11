class CreateBatchScores < ActiveRecord::Migration[6.0]
  def change
    create_table :batch_scores do |t|
      t.string :batch, null: false
      (1..25).each do |day|
        t.integer "score_#{day}".to_sym, null: false, default: 0
        t.integer "bonus_#{day}".to_sym, null: false, default: 0
      end
      t.integer :score_total, null: false, default: 0

      t.timestamps
    end
  end
end
