class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit: 100, null: false
      t.string :password, limit: 16, null: false
    end
    add_index :users, :email, unique: true
  end
end
