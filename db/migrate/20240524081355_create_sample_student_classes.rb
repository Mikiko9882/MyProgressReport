class CreateSampleStudentClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_student_classes do |t|
      t.string :name, null: false
      t.references :sample_school, foreign_key: true

      t.timestamps
    end
  end
end
