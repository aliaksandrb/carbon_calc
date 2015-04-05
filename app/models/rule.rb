class Rule < ActiveRecord::Base
  belongs_to :category

  validates :field_type, :field_name, :operation, :comparative, :points, presence: true
  validates :field_type, inclusion: { in: Field::SUPPORTED_TYPES }

  def self.options_for_type(type)
    case type
    when 'string'
      ['=']
    when 'integer'
      %w(= > < * / >= <=)
    when 'boolean'
      ['=', '!=']
    else
      ['=']
    end
  end
end

# == Schema Information
#
# Table name: rules
#
#  id          :integer          not null, primary key
#  field_type  :string           default("Integer")
#  field_name  :string           not null
#  operation   :string           not null
#  comparative :string           not null
#  points      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
