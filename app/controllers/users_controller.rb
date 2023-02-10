class UsersController < ApplicationController
    # no auth needed to create a new user
    skip_before_action :authorize, only: [:create]
    # Sign Up Feature
    def create
        # Save a new user to the database with their username, encrypted password, image URL, and bio
        user = User.create!(user_params)
        # Save the user's ID in the session hash
        session[:user_id] = user.id
        # Return a JSON response with the user's ID, username, image URL, and bio; and an HTTP status code of 201 (Created)
        render json: user, status: :created
    end

    def show
            render json: current_user, status: :ok
    end


private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

end
