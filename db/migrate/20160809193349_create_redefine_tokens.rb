class CreateRedefineTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :redefine_tokens do |t|
      t.string :token, limit: 192, null: false
      t.belongs_to :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
