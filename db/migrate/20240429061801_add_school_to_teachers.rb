class AddSchoolToTeachers < ActiveRecord::Migration[7.1]
  def change
    add_reference :teachers, :school, null: false, foreign_key: true
  end
end
