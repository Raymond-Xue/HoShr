module LesseeRequestService

  def create_request(group_id, city_id, state_id, country_id)
    lessee_request = LesseeRequest.new()
    lessee_request.group_id = group_id
    lessee_request.city_id = city_id
    lessee_request.state_id = state_id
    lessee_request.country_id = country_id
    lessee_request.save
    return lessee_request.id
  end

end
