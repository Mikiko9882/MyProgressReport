class CreateTestNames < ActiveRecord::Migration[7.1]
  def change
    create_table :test_names do |t|
      t.string :test_name, null: false
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
