class User < ApplicationRecord
	has_many :property
	has_many :lessor_request, :through => :property	

	belongs_to :current_group, foreign_key: :current_group_id, class_name: "Group"
  # belongs_to :origin_group, foreign_key: :origin_group_id, class_name: "Group"
end
