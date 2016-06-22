class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :code, limit: 30, null: false
      t.string :name, limit: 100, null: false
      t.decimal :workload, precision: 7, scale: 2, null: false, default: 0

      t.index :code, unique: true
    end
  end
end
