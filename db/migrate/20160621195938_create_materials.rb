class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :mime
      t.text :key, null: false, unique: true
      t.boolean :checked, default: false
      t.datetime :uploaded_at

      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
