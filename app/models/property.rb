class Property < ApplicationRecord
	has_many_attached :avatar
	belongs_to :owner, foreign_key: :owner_id, class_name: "User"
	belongs_to :city, foreign_key: :city_id, class_name: "City"
	belongs_to :type, foreign_key: :type_id, class_name: "Type"
	has_many :lessor_request
	has_many :room
	validates :street_address, uniqueness: {scope: [:city]}
end
