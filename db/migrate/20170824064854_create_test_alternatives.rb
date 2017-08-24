class CreateTestAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :test_alternatives do |t|
      t.text :answer, null: true
      t.boolean :correct, null: true
      t.references :person, foreign_key: true, null: false
      t.references :test, foreign_key: true, null: false
      t.references :test_question, foreign_key: true, null: false

      t.timestamps
    end
  end
end
