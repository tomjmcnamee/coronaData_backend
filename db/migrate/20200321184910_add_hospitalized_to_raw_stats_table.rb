class AddHospitalizedToRawStatsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :raw_stats_tables, :hospitalized, :string
  end
end
