class UsersController < ApplicationController
    skip_before_action :authorize, only: :create

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, serializer: UserSerializer, status: :created

    end
    
  
    def show
        user = User.find(session[:user_id])
        render json: user, serializer: UserSerializer, status: :ok
    end
      
    private
  
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio, :user_id)
    end

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session[:user_id]
    end
end
  