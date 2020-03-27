class LesseeRequest < ApplicationRecord
	belongs_to :group
	GENDER_TYPES = ["Male", "Female", "Other", "Not Matter"]
end
