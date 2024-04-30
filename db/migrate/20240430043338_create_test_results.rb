class CreateTestResults < ActiveRecord::Migration[7.1]
  def change
    create_table :test_results do |t|
      t.references :student, foreign_key: true
      t.references :test_name, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :max_score, foreign_key: true
      
      t.integer :score, null: false
      t.integer :preparation_time_minutes, null: false
      t.float :achievement_rate
      
      t.timestamps
    end
  end
end
