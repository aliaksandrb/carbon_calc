json.array!(@documents) do |document|
  json.extract! document, :id, :data, :category_id
  json.url document_url(document, format: :json)
end
