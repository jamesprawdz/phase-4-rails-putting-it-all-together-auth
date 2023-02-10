class SessionsController < ApplicationController
  # no auth needed to login
  skip_before_action :authorize, only: [:create]
  
  # Login feature
  def create
    user = User.find_by(username: params[:username])
    # checks to see if username and pass are authenticated
    if user&.authenticate(params[:password])
      # sabes the user's ID in the session hash
      session[:user_id] = user.id
      render json: user, status: :created
    else
      # if not authenticated, return an error message
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  # Logout feature
  def destroy
    # If user is logged in - remove the user's ID from the session hash
    session.delete :user_id
    head :no_content
  end

end
