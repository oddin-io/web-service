class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string :subject, limit: 30, null: false
      t.integer :status, null: false
      t.datetime :created_at, null: false

      t.references :instruction, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false
    end
  end
end
