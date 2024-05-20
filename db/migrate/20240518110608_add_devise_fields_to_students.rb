class AddDeviseFieldsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :encrypted_password, :string, null: false, default: ""
    add_column :students, :reset_password_token, :string
    add_column :students, :reset_password_sent_at, :datetime
    add_column :students, :remember_created_at, :datetime

    add_index :students, :reset_password_token, unique: true
  end
end
