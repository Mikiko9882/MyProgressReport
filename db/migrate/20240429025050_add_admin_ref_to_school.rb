class AddAdminRefToSchool < ActiveRecord::Migration[7.1]
  def change
    add_reference :schools, :admin, null: false, foreign_key: true
  end
end
