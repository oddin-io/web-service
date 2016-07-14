class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :token, limit: 192, null: false
      t.belongs_to :user, foreign_key: true, null: false

      t.timestamps null: false

      t.index :token, unique: true
    end
  end
end
