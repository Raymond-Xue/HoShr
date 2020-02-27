json.extract! city, :id, :city_name, :state_id, :country_id, :max_latitude, :min_latitude, :max_longitude, :min_longitude, :created_at, :updated_at
json.url city_url(city, format: :json)
