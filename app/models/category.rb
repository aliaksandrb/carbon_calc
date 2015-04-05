class Category < ActiveRecord::Base
  has_many :documents, dependent: :destroy
  has_and_belongs_to_many :fields
  has_many :rules, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z]\w*\z/ }
  validates_presence_of :fields
end

# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#
