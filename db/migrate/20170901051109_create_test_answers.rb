class CreateTestAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :test_answers do |t|
      t.text :answer
      
      t.references :person, foreign_key: true, null: false
      t.references :test_question, foreign_key: true, null: false
      t.references :test_alternative, foreign_key: true

      t.timestamps
    end
  end
end
