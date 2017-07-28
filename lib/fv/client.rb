module FV
  module Client
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= _configuration_class.public_send(:new)
    end

    def api_token=(token)
      configuration.api_token = token
    end

    def api_token
      configuration.api_token
    end

    def request(*args, **kargs)
      raise InvalidConfigurationError unless configuration.valid?
      handle_errors do
        send_request(*args, **kargs)
      end
    end

    private

    def configuration_class(klass)
      @configuration_class = klass
    end

    # Implement to modify the api_token if authentication fails.
    # A request will retry once after failure if this method returns a truthy
    # value.
    def handle_authentication_failure
    end

    def full_uri_for_path(path)
      "#{configuration.api_url}#{path}"
    end

    def http_response_for(&_block)
      FV::HttpResponse.new(yield).tap { |response| verify_response(response) }
    end

    def handle_errors(&block)
      http_response_for(&block)
    rescue FV::AuthenticationError => e
      raise e unless handle_authentication_failure
      http_response_for(&block)
    rescue Timeout::Error
      raise TimeoutError
    end

    def verify_response(response)
      return if response.successful?
      raise response.errors[0] ||
        FV::UnknownResponseError.new(response.raw_response.to_s)
    end

    def jsonapi_headers
      {
        'Content-Type' => FV::MIME_TYPE,
        'Accept' => FV::MIME_TYPE,
        'Authorization' => "Bearer #{configuration.api_token}"
      }
    end

    def send_request(action, path, headers: {}, body: nil, params: {})
      HttpClient.send(
        action,
        full_uri_for_path(path),
        headers: jsonapi_headers.merge(headers),
        body: body,
        verify: configuration.__verify_ssl__,
        query: params
      )
    end

    def _configuration_class
      @configuration_class ||= Configuration
    end
  end
end
