module RulesHelper
  def field_types_for_rule(category)
    category ? category.fields.map(&:field_type) : Field::SUPPORTED_TYPES
  end

  def field_names_for_rule(category)
    category ? category.fields.map(&:name) : Field.all.order(:name)
  end

end
