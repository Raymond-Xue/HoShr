class User < ApplicationRecord
	has_many :property
	has_many :lessor_request, :through => :property	
	has_many :lessee_request
end
