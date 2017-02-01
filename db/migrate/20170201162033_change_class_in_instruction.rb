class ChangeClassInInstruction < ActiveRecord::Migration[5.0]
  def change
    rename_column :instructions, :class_number, :class_code
    change_column :instructions, :class_code, :string
  end
end
