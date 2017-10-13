class CreateTestAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :test_alternatives do |t|
      t.text :text, null: true
      t.boolean :correct, default: false, null: true
      
      t.references :test_question, foreign_key: true, null: false

      t.timestamps
    end
  end
end