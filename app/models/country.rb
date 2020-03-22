class Country < ApplicationRecord
	has_many :states
	#has_many :state, :through => :city
end
