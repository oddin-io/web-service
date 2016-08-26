class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean :up, default: true, null: false
      t.belongs_to :person, foreign_key: true, null: false
      t.belongs_to :votable, polymorphic: true, null: false, index: true

      t.index [:person_id, :votable_id, :votable_type], unique: true
    end
  end
end
