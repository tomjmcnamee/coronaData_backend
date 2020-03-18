class CreateCoronaStats < ActiveRecord::Migration[6.0]
  def change
    create_table :corona_stats do |t|
      t.integer :date
      t.string :state
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
