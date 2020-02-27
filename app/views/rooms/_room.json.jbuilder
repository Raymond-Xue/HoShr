json.extract! room, :id, :room_id, :property_id, :area, :area_unit, :hasBalcony, :hasPrivateBath, :status, :created_at, :updated_at
json.url room_url(room, format: :json)
