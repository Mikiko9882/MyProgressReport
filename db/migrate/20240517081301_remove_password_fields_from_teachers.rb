class RemovePasswordFieldsFromTeachers < ActiveRecord::Migration[7.1]
  def change
    remove_column :teachers, :encrypted_password, :string
    remove_column :teachers, :reset_password_token, :string
    remove_column :teachers, :reset_password_sent_at, :datetime
    remove_column :teachers, :remember_created_at, :datetime
  end
end
