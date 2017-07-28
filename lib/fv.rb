require 'httparty'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/indifferent_access'
require 'fv/configuration'
require 'fv/client'
require 'fv/http_response'
require 'fv/exceptions'
require 'fv/api_resource'
require 'fv/url_param'
require 'fv/http_client'
require 'fv/has_many_association'

module FV
  MIME_TYPE = 'application/vnd.api+json'.freeze
end
