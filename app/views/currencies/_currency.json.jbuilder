json.extract! currency, :id, :currency_name, :currency_symbol, :conversion_rate_to_usd, :created_at, :updated_at
json.url currency_url(currency, format: :json)
