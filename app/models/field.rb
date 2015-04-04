class Field < ActiveRecord::Base
end

# == Schema Information
#
# Table name: fields
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  field_type    :string           default("string")
#  default_value :string
#
