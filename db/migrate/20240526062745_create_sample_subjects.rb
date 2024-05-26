class CreateSampleSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_subjects do |t|
      t.string :subject_name, null: false
      t.references :sample_teacher, foreign_key: true

      t.timestamps
    end
  end
end
