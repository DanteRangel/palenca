class HandlerError
    attr_reader :message, :details, :status

    def self.message(message:, details:, status:)
        _message = message || 'exception_error'
        _details = details || {}
        _status = status || :unprocessable_entity
        self.message_response(_message, _details, _status)
    end

    def self.message_response(message, details, status)
        {json: { message: message , details: details }, status: status}
    end
end