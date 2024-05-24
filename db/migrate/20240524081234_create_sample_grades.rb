class CreateSampleGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_grades do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
