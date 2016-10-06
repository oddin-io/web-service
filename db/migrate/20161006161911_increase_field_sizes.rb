class IncreaseFieldSizes < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :text, :text
    change_column :answers, :text, :text
    change_column :notices, :subject, :text
    change_column :notices, :text, :text
    change_column :calendars, :subject, :text
    change_column :calendars, :text, :text
  end
end
