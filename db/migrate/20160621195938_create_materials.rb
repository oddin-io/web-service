class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name, limit: 50
      t.string :mime, limit: 50
      t.binary :file
    end
  end
end
