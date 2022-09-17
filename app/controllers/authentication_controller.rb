class AuthenticationController < ApiGuard::AuthenticationController
    before_action :find_resource, only: [:authentication]
    before_action :authenticate_resource, only: [:destroy]

    def authentication  
      if resource.authenticate(params[:password])
          successful_reponse(resource, resource_name)
        else
          render HandlerError.message(
              message: "CREDENTIALS_INVALID",
              details: "Incorrect username or password",
              status: :unauthorized)
        end
      rescue => e
        Rails.logger.debug "Exception error ::: #{e.message}" 
        render HandlerError.message(
          message: "AUTH_EXCEPTION",
          details: "Auth #{params[:platform]} Exception",
          status: :unauthorized)
    end

    def health_check
      Rails.logger.debug "health endpont :::"
      render json: { message: "OK" }
    end

    def auth_params
      params.permit(:email, :password, :platform)
    end

    private

    def find_resource
      self.resource = resource_class.find_by(email: params[:email]&.downcase&.strip, platform: params[:platform]&.downcase&.strip) if params[:email].present?
  
      return render HandlerError.message(
        message: "CREDENTIALS_INVALID",
        details: "Incorrect username or password",
        status: :unauthorized) unless resource
    end

    def successful_reponse(resource, resource_name) 
      render json: {message: "SUCCESS", access_token: resource.token}, status: :ok
    end
end
  