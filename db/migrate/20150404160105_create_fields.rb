class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.string :field_type, default: 'string'
      t.string :default_value
    end
  end
end
