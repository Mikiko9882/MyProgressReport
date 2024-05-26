class CreateSampleTestNames < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_test_names do |t|
      t.string :test_name, null: false
      t.references :sample_teacher, foreign_key: true

      t.timestamps
    end
  end
end
