class UsersController < ApplicationController
  before_action :authorize_request
  
  def profile
      render json: @current_user, serializer: UserProfileSerializer, message: "SUCCESS", status: :ok
    end

    def permit_params
        params.permit(:platform, :acces_token)
    end
end
