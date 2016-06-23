class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.attachment :file, null: false
    end
  end
end
