class CreateAnswersMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :answers_materials do |t|
      t.belongs_to :answer, foreign_key: true, null: false
      t.belongs_to :material, foreign_key: true, null: false
    end
  end
end
