class Group < ApplicationRecord
	has_many :lessee_request
	has_many :users, foreign_key: "current_group_id"
	has_one :original_user, foreign_key: "origin_group_id", class_name: "User"

	has_many :send_invitation, foreign_key: "group_from_id", class_name: "Invitation"
	has_many :received_invitation, foreign_key: "group_to_id", class_name: "Invitation"
end
