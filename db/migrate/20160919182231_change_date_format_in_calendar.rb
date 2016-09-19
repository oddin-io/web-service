class ChangeDateFormatInCalendar < ActiveRecord::Migration[5.0]
  def up
    change_column :calendars, :date, :datetime
  end

  def down
    change_column :calendars, :date, :date
  end
end
