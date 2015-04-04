class Field < ActiveRecord::Base
  belongs_to :category

  before_validation :normalize_field_type

  validates :name, :field_type, :default_value, presence: true
  validates :name, format: { with: /\A[a-zA-Z]\w*\z/ }
  validates :field_type, inclusion: { in: %w(Integer String Boolean) }

  def name_with_type
    "#{name}: #{field_type}"
  end

  protected

  def normalize_field_type
    if field_type
      self.field_type = field_type.capitalize
    end
  end

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
