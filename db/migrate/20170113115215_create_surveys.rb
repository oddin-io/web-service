class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.string :question, null: false
      t.references :instruction, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
