class CreatePresentations < ActiveRecord::Migration[5.0]
  def change
    create_table :presentations do |t|
      t.string :subject, limit: Presentation::SUBJECT_MAX_LENGTH, null: false
      t.integer :status, null: false, default: 0
      t.datetime :created_at, null: false

      t.belongs_to :instruction, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
