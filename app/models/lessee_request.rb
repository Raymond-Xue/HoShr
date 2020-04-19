class LesseeRequest < ApplicationRecord
	belongs_to :group
	GENDER_TYPES = ["Male", "Female", "Other", "Not Matter"]
	attr_accessor :city
	attr_accessor :state
	attr_accessor :country
end
