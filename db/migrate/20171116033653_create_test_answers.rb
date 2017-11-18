class CreateTestAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :test_answers do |t|
      t.text :response, null: true
      t.integer :choice, null: true
      t.float :value, null: true
      t.text :comment, null: true
      
      t.references :test_response, foreign_key: true, null: false
      t.references :test_question, foreign_key: true, null: false
      t.references :test_alternative, foreign_key: true, null: false

      t.timestamps
    end
  end
end
