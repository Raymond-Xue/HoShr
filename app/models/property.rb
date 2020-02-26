class Property < ApplicationRecord
	belongs_to :user
	has_many :lessor_request
end
