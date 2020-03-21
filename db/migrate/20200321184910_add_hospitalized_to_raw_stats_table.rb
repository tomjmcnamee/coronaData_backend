class AddHospitalizedToRawStatsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :raw_stats, :hospitalized, :string
  end
end
