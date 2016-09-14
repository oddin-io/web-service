class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.string :text, limit: 50
      t.string :subject, limit: 20
      t.date :date
      t.belongs_to :instruction, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
