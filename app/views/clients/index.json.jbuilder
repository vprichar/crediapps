json.array!(@clients) do |client|
  json.extract! client, :id, :name, :rfc, :phone, :email
  json.url client_url(client, format: :json)
end
