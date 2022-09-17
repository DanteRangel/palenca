class ApplicationController < ActionController::API
    attr_accessor :current_user

    def authorize_request
        access_token = params[:access_token]

        begin
            @current_user ||= User.find_by(token: access_token)
            return render HandlerError.message(
                message: "CREDENTIALS_INVALID",
                details: "Incorrect token",
                status: :unauthorized) unless @current_user

        rescue ActiveRecord::RecordNotFound => e
            render HandlerError.message(
            message: "CREDENTIALS_INVALID",
            details: "Incorrect token",
            status: :unauthorized)
        rescue JWT::DecodeError => e
            render HandlerError.message(
            message: "CREDENTIALS_INVALID",
            details: "Incorrect token",
            status: :unauthorized)
        end
    end
end
