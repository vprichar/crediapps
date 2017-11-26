json.array!(@configuracions) do |configuracion|
  json.extract! configuracion, :id, :financing_rate, :Deadline
  json.url configuracion_url(configuracion, format: :json)
end
