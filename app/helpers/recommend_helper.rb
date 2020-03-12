module RecommendHelper

  # hard sql to get list of requests
  # soft rate the requests
  # rank request by the rating
  # get group from the ranked request
  def find_recommend_group(request_id)
    group_request = LesseeRequest.find(request_id)
    if group_request.nil?
      raise "LesseeRequest not found."
    end
    request_list = recommend_request_sql_query(group_request)
    request_list.sort_by do |other_request|
      soft_rating(group_request, other_request)
    end

    extract_group_from_requests(request_list)

  end

  private
  def recommend_request_sql_query(group_request)
    LesseeRequest.where("group_id != #{group_request.group_id}")
  end

  def soft_rating(request_1, request_2)
    return 1
  end

  def extract_group_from_requests(ordered_requests, group_num = 10)
    require 'set'
    group_set = Set[]
    group_list = []

    ordered_requests.each do |request|
      if !group_set.include?(request.group_id) &&
          group_list.length < group_num
        group_list.push(request.group)
        group_set.add(request.group_id)
      end
    end
    return group_list
  end

end
