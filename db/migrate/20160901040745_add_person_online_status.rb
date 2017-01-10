class AddPersonOnlineStatus < ActiveRecord::Migration[5.0]
  def change
    change_table :people do |t|
      t.boolean :online, default: false
      t.timestamp :last_activity
    end
  end
end
