class CreateAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :alternatives do |t|
      t.string :description, null: false
      t.references :survey, foreign_key: true, null: false

      t.timestamps
    end
  end
end
