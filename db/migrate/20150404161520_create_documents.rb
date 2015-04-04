class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :data, null: false
      t.belongs_to :category

      t.timestamps null: false
    end

    add_index :documents, :category_id
  end
end
