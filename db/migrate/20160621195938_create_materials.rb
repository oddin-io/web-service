class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :name, limit: 50, null: false
      t.text :type, null: false
      t.integer :size, null: false
      t.text :url, null: false, unique: true
      t.datetime :updated_at, null: false

      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
