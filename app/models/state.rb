class State < ApplicationRecord

  has_many :processed_stats
  has_many :positive_stats
  has_many :negative_stats
  has_many :pending_stats
  has_many :death_stats
  has_many :total_stats
  has_many :stay_at_home_orders
end
