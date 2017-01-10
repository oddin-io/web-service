class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.text :text
      t.belongs_to :work, foreign_key: true, null: false
      t.belongs_to :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
