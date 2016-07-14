class CreateInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.integer :class_number, null: false, default: 1
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.belongs_to :event, foreign_key: true, null: false
      t.belongs_to :lecture, foreign_key: true, null: false
    end
  end
end