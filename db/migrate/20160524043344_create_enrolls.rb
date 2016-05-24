class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :profile, null: false

      t.references :person, foreign_key: true, null: false
      t.references :instruction, foreign_key: true, null: false
    end
    add_index :enrolls, [:person_id, :instruction_id], unique: true
  end
end
