module FV
  class Configuration
    attr_accessor :api_url,
                  :api_token,
                  :__verify_ssl__

    def initialize
      @__verify_ssl__ = true
    end

    def valid?
      api_url && api_token
    end
  end
end
