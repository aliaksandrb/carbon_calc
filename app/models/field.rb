class Field < ActiveRecord::Base
  belongs_to :category
end

# == Schema Information
#
# Table name: fields
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  field_type    :string           default("string")
#  default_value :string
#  category_id   :integer
#
# Indexes
#
#  index_fields_on_category_id  (category_id)
#
