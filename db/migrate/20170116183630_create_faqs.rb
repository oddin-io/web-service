class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
      t.string :question
      t.string :answer
      t.references :instruction, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
