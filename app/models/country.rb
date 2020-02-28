class Country < ApplicationRecord
	has_many :state
	has_many :state, :through => :city
end
