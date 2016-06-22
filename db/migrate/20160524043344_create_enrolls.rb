class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :profile, null: false

      t.belongs_to :person, foreign_key: true, null: false
      t.belongs_to :instruction, foreign_key: true, null: false

      t.index [:person_id, :instruction_id], unique: true
    end
  end
end
