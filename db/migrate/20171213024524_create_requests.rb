class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.boolean :status, null: false, default: false
      t.references :person, foreign_key: true, null: false
      t.references :presentation, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
