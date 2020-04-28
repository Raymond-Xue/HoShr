
module RecommendationService

  # hard sql to get list of requests
  # soft rate the requests
  # rank request by the rating
  # get group from the ranked request
  def find_recommendation(group_id)
    requests = LesseeRequest.where(group_id: group_id)

    all_match_requests = []
    # hard sql to get list of request
    requests.each do |request|
      all_match_requests = all_match_requests.union(recommend_request_sql_query(request)).uniq
    end

    # sort the request by soft rating
    all_match_requests.sort_by do |other_request|
      score = 0
      requests.each do |request|
        new_score = soft_rating(request, other_request)
        if new_score > score
          score = new_score
        end
      end
    end
    # extract the group from the requests
    extract_group_from_requests(all_match_requests)
  end


  private

  # Return the recommended requests in array
  def recommend_request_sql_query(group_request)
    sql_select_requests = LesseeRequest.where("group_id != #{group_request.group_id} and active != false")
        .where("city_id = #{group_request.city_id} and state_id = #{group_request.state_id} and country_id = #{group_request.country_id}")
        .where("smoke = #{group_request.smoke}")
        .where("max_rent <= #{group_request.max_rent + 300} and max_rent >= #{group_request.max_rent - 300}")
    # |a - b| <= 300
    # a <= 300 + b && a >= -300 + b

    current_group_num = group_request.group.users.count
    select_requests = []
    sql_select_requests.each do |request|
      if request.group.users.count + current_group_num <= group_request.max_n_housemates &&
          group_request.latest_movein_date >= request.earliest_movein_date &&
          group_request.earliest_movein_date <= request.latest_movein_date &&
          group_request.min_duration <= request.max_duration &&
          group_request.max_duration >= request.min_duration
        select_requests.push(request)
      end
    end
    select_requests
  end

  # Rate two requests
  def soft_rating(my_request, other_request)
    distance = Geocoder::Calculations.distance_between([my_request.latitude, my_request.longitude],
                                            [other_request.latitude, other_request.longitude], {units: :km})
    distance_score = 0
    if distance <= my_request.radius
      distance_score = 40
    elsif distance <= my_request.radius * 2
      distance_score = 20 + 20 * (distance - my_request.radius) / my_request.radius
    elsif distance <= my_request.radius * 3
      distance_score = 20 * (distance - my_request.radius * 2) / my_request.radius
    else
      distance_score = 0
    end

    rent_score = 0
    diff_rent = other_request.max_rent - my_request.max_rent
    if diff_rent <= 0
      rent_score = 60
    elsif diff_rent <= 100
      rent_score = 40 + 10 * diff_rent / 100
    elsif diff_rent <= 200
      rent_score = 20 + 10 * diff_rent / 200
    elsif diff_rent <= 300
      rent_score = 10 * diff_rent / 300
    else
      rent_score = 0
    end
    rent_score + distance_score
  end

  # Extract groups from a list of ordered requests. Return the order hash
  # with {[group_id: request],...}
  def extract_group_from_requests(ordered_requests, group_num = 10)

    ordered_hash = ActiveSupport::OrderedHash.new
    ordered_requests.each do |request|
      if ordered_hash.size >= group_num
        break
      end
      if !ordered_hash.include?(request.group_id)
        ordered_hash[request.group_id] = [request]
      else
        ordered_hash[request.group_id].push(request)
      end
    end
    return ordered_hash
  end

end
