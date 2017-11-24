json.array!(@furnitures) do |furniture|
  json.extract! furniture, :id, :barcode, :name, :description, :price, :cost_price, :status
  json.url furniture_url(furniture, format: :json)
end
