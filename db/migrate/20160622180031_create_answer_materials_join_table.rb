class CreateAnswerMaterialsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :materials, :answers do |t|
      t.references :answer, foreign_key: true, null: false
      t.references :material, foreign_key: true, null: false

      t.index [:answer_id, :material_id], unique: true, name: :uk_answers_materials
    end
  end
end