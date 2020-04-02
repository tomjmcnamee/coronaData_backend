class CreateRawStats < ActiveRecord::Migration[6.0]
  def change
    create_table :raw_stats do |t|
      t.integer :date
      t.string :state
      t.integer :positive
      t.integer :negative
      t.integer :hospitalized
      t.integer :death
      t.integer :total
      t.datetime :dateChecked

      t.timestamps
    end
  end
end
