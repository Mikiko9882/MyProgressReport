class CreateSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :website
      t.string :code

      t.timestamps
    end
    add_index :schools, :code, unique: true
  end
end
