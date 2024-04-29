class CreateMaxScores < ActiveRecord::Migration[7.1]
  def change
    create_table :max_scores do |t|
      t.integer :max_score, null: false
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
