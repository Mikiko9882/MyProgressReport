class CreateTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :targets do |t|
      t.references :student, foreign_key: true
      t.references :test_name, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :max_score, foreign_key: true

      t.integer :target_score
      t.integer :target_preparation_time_minutes
      t.float :target_achievement_rate

      t.timestamps
    end
  end
end
