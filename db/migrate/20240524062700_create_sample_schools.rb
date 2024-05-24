class CreateSampleSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_schools do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :website
      t.string :code

      t.timestamps
    end
    add_index :sample_schools, :code, unique: true
  end
end
