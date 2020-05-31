class State < ApplicationRecord
  has_many :processed_stats
  has_many :total_stats
  has_many :stay_at_home_orders
  has_many :data_quality_grades
end

