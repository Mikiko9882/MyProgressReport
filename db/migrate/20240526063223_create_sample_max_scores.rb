class CreateSampleMaxScores < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_max_scores do |t|
      t.integer :max_score, null: false
      t.references :sample_teacher, foreign_key: true

      t.timestamps
    end
  end
end
