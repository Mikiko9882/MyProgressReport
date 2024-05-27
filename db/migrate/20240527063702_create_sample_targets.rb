class CreateSampleTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_targets do |t|
      t.references :sample_student, foreign_key: true
      t.references :sample_test_name, foreign_key: true
      t.references :sample_subject, foreign_key: true
      t.references :sample_max_score, foreign_key: true

      t.integer :target_score
      t.integer :target_preparation_time_minutes
      t.float :target_achievement_rate

      t.timestamps
    end
  end
end
