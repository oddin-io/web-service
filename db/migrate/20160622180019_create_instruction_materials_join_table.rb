class CreateInstructionMaterialsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :materials, :instructions do |t|
      t.references :instruction, foreign_key: true, null: false
      t.references :material, foreign_key: true, null: false

      t.index [:instruction_id, :material_id], unique: true, name: :uk_instructions_materials
    end
  end
end
