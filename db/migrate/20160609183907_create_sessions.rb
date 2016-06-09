class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token, limit: 192, null: false
      t.belongs_to :user, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :sessions, :token, unique: true
  end
end
