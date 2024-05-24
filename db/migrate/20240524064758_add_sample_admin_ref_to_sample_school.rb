class AddSampleAdminRefToSampleSchool < ActiveRecord::Migration[7.1]
  def change
    add_reference :sample_schools, :sample_admin, null: false, foreign_key: true
  end
end
