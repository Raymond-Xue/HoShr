class Property < ApplicationRecord
	after_commit :add_default_cover, on: [:create, :update]
	has_many_attached :avatar
	belongs_to :owner, foreign_key: :owner_id, class_name: "User"
	belongs_to :city, foreign_key: :city_id, class_name: "City"
	belongs_to :type, foreign_key: :type_id, class_name: "Type"
	has_many :lessor_request
	has_many :room
	validates :street_address, uniqueness: {scope: [:city]}


    private def add_default_cover
	unless avatar.attached?
		self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "house_default.png")), filename: 'house_default.png' , content_type: "image/png")
	  end
	end
end
