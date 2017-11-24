json.array!(@payments) do |payment|
  json.extract! payment, :id, :sale_id, :amount
  json.url payment_url(payment, format: :json)
end
