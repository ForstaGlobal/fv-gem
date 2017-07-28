module FV
  class HttpResponse
    attr_reader :raw_response

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def successful?
      raw_response.success?
    end

    def data
      json[:data]
    end

    def errors
      @errors ||= begin
        if successful?
          []
        elsif json.key?(:errors)
          Array(json[:errors]).map { |error| ApiError.from_raw(error) }
        else
          [
            ApiError.from_raw(
              'code' => raw_response.code,
              'status' => raw_response.code
            )
          ]
        end
      end
    end

    def json
      @json ||= JSON.parse(raw_response.body).with_indifferent_access
    end
  end
end
