class HealthChecksController < ApplicationController
    def hello_palenca
        Rails.logger.debug "Hellow Palenca"
        render html: "Hellow Palenca"
    end

    def health_check
      Rails.logger.debug "health endpont :::"
      render json: { message: "OK" }
    end
end
  