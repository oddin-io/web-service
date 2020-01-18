class AddClusterToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :cluster, foreign_key: true, null: true
  end
end
