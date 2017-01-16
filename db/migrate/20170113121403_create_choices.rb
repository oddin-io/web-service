class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.references :alternative, foreign_key: true, null: false
      t.references :survey, foreign_key: true, null: false
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
