class CreateCluster < ActiveRecord::Migration[5.0]
  def change
    create_table :clusters do |t|
    	t.belongs_to :presentation, foreign_key: true, null: false
    end
  end
end
