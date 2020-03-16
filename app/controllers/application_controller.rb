class ApplicationController < ActionController::Base
	include SessionsHelper
	def hello
		render html: "hello world"
	end

	def logged_in_user
        unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
end
