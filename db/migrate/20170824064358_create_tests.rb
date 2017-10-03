class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.datetime :available_at, null: false
      t.datetime :closes_at, null: false
      
      t.references :instruction, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false  

      t.timestamps
    end
  end
end
