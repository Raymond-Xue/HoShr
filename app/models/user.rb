class User < ApplicationRecord
	has_many :property
	has_many :lessor_request, :through => :property	
	has_many :lessee_request

	belongs_to :group, optional: true
	belongs_to :origin_group, foreign_key: :origin_group_id, class_name: "Group"
end
