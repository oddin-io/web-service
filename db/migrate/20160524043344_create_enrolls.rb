class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :profile, null: false

      t.references :person, index: true, foreign_key: true, null: false
      t.references :instruction, index: true, foreign_key: true, null: false
    end
  end
end
