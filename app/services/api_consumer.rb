require 'httparty'

class ApiConsumer
  include HTTParty
  base_uri 'https://api.stagingeb.com/v1'

  class ApiError < StandardError
    attr_reader :status, :message

    def initialize(status, message)
      @status = status
      @message = message
      super(message)
    end
  end

  def obtener_datos(endpoint)
    headers = {
      'X-Authorization' => 'l7u502p8v46ba3ppgvj5y2aad50lb9',
      'Accept' => 'application/json'
    }
    response = self.class.get(endpoint, headers: headers)
    if response.success?
      response.parsed_response
    else
      error_message = response.parsed_response['error'] || 'Unknown error'
      raise ApiError.new(response.code, error_message)
    end
  end
end