class CreatePresentationsMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :presentations_materials do |t|
      t.belongs_to :presentation, foreign_key: true, null: false
      t.belongs_to :material, foreign_key: true, null: false
    end
  end
end
