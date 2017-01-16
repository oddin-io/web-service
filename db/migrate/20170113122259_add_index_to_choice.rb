class AddIndexToChoice < ActiveRecord::Migration[5.0]
  def change
    add_index :choices, [:person_id, :survey_id], unique: true
    add_index :choices, [:person_id, :alternative_id], unique: true
  end
end
