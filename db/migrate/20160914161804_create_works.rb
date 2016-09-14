class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.text :subject, null: false
      t.text :description, null: false
      t.timestamp :deadline, null: false
      t.belongs_to :instruction, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
