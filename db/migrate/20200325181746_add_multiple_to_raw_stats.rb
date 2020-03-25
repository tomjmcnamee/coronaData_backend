class AddMultipleToRawStats < ActiveRecord::Migration[6.0]
  def change
    add_column :raw_stats, :deathIncrease, :integer
    add_column :raw_stats, :hospitalizedIncrease, :integer
    add_column :raw_stats, :negativeIncrease, :integer
    add_column :raw_stats, :positiveIncrease, :integer
    add_column :raw_stats, :totalTestResultsIncrease, :integer
  end
end
