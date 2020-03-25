class AddTotalTestResultsToRawStats < ActiveRecord::Migration[6.0]
  def change
    add_column :raw_stats, :totalTestResults, :integer
  end
end
