class CreateBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :batches do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
