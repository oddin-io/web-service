class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text, limit: 140, null: false
      t.boolean :anonymous, null: false, default: false
      t.datetime :created_at, null: false

      t.references :presentation, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false
    end
  end
end
