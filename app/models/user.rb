class User < ApplicationRecord
	has_many :property
	has_many :lessor_request, :through => :property	
end
