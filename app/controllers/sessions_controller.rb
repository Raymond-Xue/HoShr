class SessionsController < ApplicationController
  def new
    render 'new'
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
	  log_in user
	  redirect_to root_path
    else
      # Create an error message.
      render 'new'
	  flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
    end
  end
  def destroy
    log_out
    redirect_to root_url
  end
end
