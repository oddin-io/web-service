class AlterColumnTestQuestion < ActiveRecord::Migration[5.0]
  def change
  	change_column :test_questions, :value, :float, null:false
  end
end
