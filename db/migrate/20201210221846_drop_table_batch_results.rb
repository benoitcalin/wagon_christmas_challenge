class DropTableBatchResults < ActiveRecord::Migration[6.0]
  def change
    drop_table :batch_results
  end
end
