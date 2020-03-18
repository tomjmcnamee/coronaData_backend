class CreateProcessedStats < ActiveRecord::Migration[6.0]
  def change
    create_table :processed_stats do |t|
      t.integer :date
      t.references :state, null: false, foreign_key: true
      t.integer :positive
      t.integer :negative
      t.integer :pending
      t.integer :death
      t.integer :total
      t.datetime :dateChecked

      t.timestamps
    end
  end
end
