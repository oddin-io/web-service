class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.integer :class, null: false, default: 1
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.references :event, index: true, foreign_key: true, null: false
      t.references :lecture, index: true, foreign_key: true, null: false
    end
  end
end
