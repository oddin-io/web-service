class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.string :text, limit: 100
      t.string :subject, limit: 50
      t.belongs_to :instruction, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
