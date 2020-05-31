class CreateRawStats < ActiveRecord::Migration[6.0]
  def change
    create_table :raw_stats do |t|
      t.integer :date
      t.string :state
      t.string :grade
      t.integer :positive
      t.integer :negative
      t.integer :hospitalized
      t.integer :death
      t.integer :total
      t.integer :deathIncrease
      t.integer :hospitalizedIncrease
      t.integer :negativeIncrease
      t.integer :positiveIncrease
      t.integer :totalTestResultsIncrease
      t.datetime :dateChecked

      t.timestamps
    end
  end
end
