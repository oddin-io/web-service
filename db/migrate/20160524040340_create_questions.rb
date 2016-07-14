class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :text, limit: 140, null: false
      t.boolean :anonymous, null: false, default: false
      t.datetime :created_at, null: false

      t.belongs_to :presentation, foreign_key: true, null: true
      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
