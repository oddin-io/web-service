class CreatePresentationMaterialsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :materials, :presentations do |t|
      t.references :presentation, foreign_key: true, null: false
      t.references :material, foreign_key: true, null: false

      t.index [:presentation_id, :material_id], unique: true, name: :uk_presentations_materials
    end
  end
end
