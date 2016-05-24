class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, limit: 100, null: false

      t.references :user, foreign_key: true, null: false
    end
  end
end
