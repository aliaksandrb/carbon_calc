class Rule < ActiveRecord::Base
  SUPPORTED_OPERATIONS = %w(== != > < * / >= <=)
  belongs_to :category

  validates :field_type, :field_name, :operation, :comparative, :points, presence: true
  validates :field_type, inclusion: { in: Field::SUPPORTED_TYPES }
  validates :operation, inclusion: { in: SUPPORTED_OPERATIONS }

  def self.options_for_type(type)
    case type
    when 'string'
      ['==']
    when 'integer'
      %w(== > < * / >= <=)
    when 'boolean'
      ['==', '!=']
    else
      ['==']
    end
  end

  def self.calculate_for!(document)
    rules = where(category_id: document.category_id)
    points = 0
    data_hash = document.deserialize_data

    rules.each do |rule|
      case rule.field_type
      when 'String'
        raw_value = "\'#{data_hash[rule.field_name]}\'"
        rule_comparative = "\'#{rule.comparative}\'"
      when 'Integer', 'Boolean'
        raw_value = data_hash[rule.field_name]
        rule_comparative = rule.comparative
      else
        raw_value = nil
        rule_comparative = rule.comparative
      end

      if raw_value
        #Rails.logger.debug("_______ #{"#{raw_value} #{rule.operation} #{rule_comparative}"}____")
        result = eval("#{raw_value} #{rule.operation} #{rule_comparative}")

        if result && rule.field_type == 'Integer' && rule.operation.in?(%w(* /))
          points += rule.points * result
        else
          points += rule.points
        end
      end
    end

    points
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
