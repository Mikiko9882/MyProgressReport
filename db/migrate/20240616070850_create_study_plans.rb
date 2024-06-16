class CreateStudyPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :study_plans do |t|
      t.references :student, foreign_key: true
      t.references :subject, foreign_key: true

      t.datetime :start_time
      t.text :content

      t.timestamps
    end
  end
end
