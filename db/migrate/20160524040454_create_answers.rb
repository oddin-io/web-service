class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text, limit: 140, null: false
      t.boolean :anonymous, null: false, default: false
      t.datetime :created_at, null: false

      t.references :question, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false
    end
  end
end
