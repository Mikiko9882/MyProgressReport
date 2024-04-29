class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :subject_name, null: false
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
