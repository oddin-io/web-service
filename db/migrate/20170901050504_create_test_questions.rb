class CreateTestQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :test_questions do |t|
      t.integer :number, null: false
      t.text :description, null: false
      t.text :answer, null: true
      t.decimal :value, null: false
      t.boolean :kind, null: false
      
      t.belongs_to :attachable, polymorphic: true, index: true
      t.references :test, foreign_key: true, null: false

      t.timestamps
    end
  end
end
