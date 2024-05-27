class AddSampleSchoolToSampleTeachers < ActiveRecord::Migration[7.1]
  def change
    add_reference :sample_teachers, :sample_school, null: false, foreign_key: true
  end
end
