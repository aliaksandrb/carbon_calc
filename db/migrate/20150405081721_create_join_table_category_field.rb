class CreateJoinTableCategoryField < ActiveRecord::Migration
  def change
    create_join_table :categories, :fields do |t|
       t.index [:category_id, :field_id]
       t.index [:field_id, :category_id]
    end

    remove_reference :fields, :category
  end
end
