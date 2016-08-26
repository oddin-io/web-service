class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name, limit: Person::NAME_MAX_LENGTH, null: false
      t.string :email, limit: Person::EMAIL_MAX_LENGTH, null: false
      t.string :password_digest, null: false

      t.index :email, unique: true
    end
  end
end
