class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :category_id, null: false
      t.integer :points, default: 0
      t.belongs_to :document

      t.timestamps null: false
    end

    add_index :results, :category_id
  end
end
