class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name, limit: 100, null: false

      t.belongs_to :user, foreign_key: true, null: false
    end
  end
end
