json.array!(@rules) do |rule|
  json.extract! rule, :id, :field_type, :field_name, :operation, :comparative, :points, :category_id
  json.url rule_url(rule, format: :json)
end
