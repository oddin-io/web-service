class AddFlagIsfaqToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :isfaq, :boolean
  end
end
