class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.attachment :upload, null: false
      t.text :download_url, null: false, unique: true

      t.belongs_to :person, foreign_key: true, null: false
    end
  end
end
