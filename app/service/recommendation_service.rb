
module RecommendationService

  # hard sql to get list of requests
  # soft rate the requests
  # rank request by the rating
  # get group from the ranked request
  def find_recommendation(group_id)
    requests = LesseeRequest.where(group_id: group_id)

    all_match_requests = LesseeRequest.none
    # hard sql to get list of request
    requests.each do |request|
      all_match_requests = all_match_requests.or(recommend_request_sql_query(request))
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

  # Return the recommended requests
  def recommend_request_sql_query(group_request)
    LesseeRequest.where("group_id != #{group_request.group_id} and active != false")
  end

  # Rate two requests
  def soft_rating(request_1, request_2)
    return 1
  end

  # Extract groups from a list of ordered requests. Return the list of group
  # containing the unique group with the same order of ordered requests
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
