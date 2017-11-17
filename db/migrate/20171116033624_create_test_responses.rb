class CreateTestResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :test_responses do |t|
      t.float :score, null: true
      t.boolean :closed, null: false, default: false
      
      t.references :test, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
