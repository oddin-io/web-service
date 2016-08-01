class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :code, limit: Event::CODE_MAX_LENGTH, null: false
      t.string :name, limit: Event::NAME_MAX_LENGTH, null: false
      t.decimal :workload, precision: 7, scale: 2, null: false, default: 0

      t.index :code, unique: true
    end
  end
end
