class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name, limit: 50, null: false
      t.string :mime, limit: 50, null: false
      t.text :file_url, null: false

      t.index :name, unique: true
    end
  end
end
