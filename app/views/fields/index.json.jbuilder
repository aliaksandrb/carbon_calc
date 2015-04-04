json.array!(@fields) do |field|
  json.extract! field, :id, :name, :field_type, :default_value
  json.url field_url(field, format: :json)
end
