class CreateDataQualityGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :data_quality_grades do |t|
      t.string :state_abbreviation
      t.references :state, null: false, foreign_key: true
      t.string :grade

      t.timestamps
    end
  end
end
