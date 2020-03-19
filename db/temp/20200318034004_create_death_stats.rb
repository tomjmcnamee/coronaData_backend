class CreateDeathStats < ActiveRecord::Migration[6.0]
  def change
    create_table :processed_stats do |t|
      t.integer :date
      t.references :state, null: false, foreign_key: true
      t.count :integer

      t.timestamps
    end
  end
end
