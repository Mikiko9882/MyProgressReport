class AddDeviseFieldsToTeachers < ActiveRecord::Migration[7.1]
  def change
    add_column :teachers, :encrypted_password, :string, null: false, default: ""
    add_column :teachers, :reset_password_token, :string
    add_column :teachers, :reset_password_sent_at, :datetime
    add_column :teachers, :remember_created_at, :datetime

    add_index :teachers, :reset_password_token, unique: true
  end
end
