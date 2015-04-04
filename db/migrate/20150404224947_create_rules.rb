class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :field_type, default: 'Integer'
      t.string :field_name, null: false
      t.string :operation, null: false
      t.string :comparative, null: false
      t.integer :points, default: 0
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
