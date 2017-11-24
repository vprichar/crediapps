json.array!(@sales) do |sale|
  json.extract! sale, :id, :payment_id, :toal, :encganche, :bonificacion, :status
  json.url sale_url(sale, format: :json)
end
