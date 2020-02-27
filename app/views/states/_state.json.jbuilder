json.extract! state, :id, :state_name, :country_id, :max_latitude, :min_latitude, :max_longitude, :min_longitude, :created_at, :updated_at
json.url state_url(state, format: :json)
