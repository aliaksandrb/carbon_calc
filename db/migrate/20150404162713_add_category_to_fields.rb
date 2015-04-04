class AddCategoryToFields < ActiveRecord::Migration
  def change
    add_reference :fields, :category, index: true, foreign_key: true
  end
end
