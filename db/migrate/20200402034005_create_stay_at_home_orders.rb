class CreateStayAtHomeOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :stay_at_home_orders do |t|
      t.integer :date
      t.references :state, null: false, foreign_key: true
      t.string :order_action

      t.timestamps
    end
  end
end
