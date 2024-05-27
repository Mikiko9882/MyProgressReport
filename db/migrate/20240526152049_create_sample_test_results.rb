class CreateSampleTestResults < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_test_results do |t|
      t.references :sample_student, foreign_key: true
      t.references :sample_test_name, foreign_key: true
      t.references :sample_subject, foreign_key: true
      t.references :sample_max_score, foreign_key: true
      
      t.integer :score, null: false
      t.integer :preparation_time_minutes, null: false
      t.float :achievement_rate

      t.timestamps
    end
  end
end
