class Property < ApplicationRecord
	belongs_to :user
	belongs_to :city
	belongs_to :type
	has_many :lessor_request
	has_many :room
end
