class CreateTotalStats < ActiveRecord::Migration[6.0]
  def change
    create_table :total_stats do |t|
      t.integer :date
      t.references :state, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
