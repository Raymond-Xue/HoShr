class LesseeRequest < ApplicationRecord
	belongs_to :user, optional: true, foreign_key: :lessee_id
	belongs_to :group
end
