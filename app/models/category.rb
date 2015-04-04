class Category < ActiveRecord::Base
  has_many :documents
  has_many :fields
end

# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#
