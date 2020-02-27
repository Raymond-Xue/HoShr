json.extract! country, :id, :country_name, :max_latitude, :min_latitude, :max_longitude, :min_longitude, :created_at, :updated_at
json.url country_url(country, format: :json)
