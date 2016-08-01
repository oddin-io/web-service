class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :text, limit: Answer::TEXT_MAX_LENGTH, null: false
      t.boolean :anonymous, null: false, default: false
      t.datetime :created_at, null: false

      t.belongs_to :question, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
