module FV
  class UrlParam
    def self.construct_url_param(key, value)
      construct_param_list(key, value).map(&:to_s).join('&')
    end

    def self.construct_param_list(key, value)
      url_params = []
      if value.respond_to?(:to_ary)
        url_params << new(keys: [key], values: value.to_ary)
      elsif value.respond_to?(:to_hash)
        url_params += construct_hash_param_list(key, value)
      else
        url_params << new(keys: key.nil? ? [] : [key], values: [value])
      end
      url_params
    end

    def self.construct_hash_param_list(key, value)
      url_params = []
      url_param = new(keys: [key])
      value.to_hash.map do |child_key, child_value|
        construct_param_list(child_key, child_value).each do |child_param|
          url_params << url_param + child_param
        end
      end
      url_params
    end

    attr_accessor :keys,
                  :values

    def initialize(keys: [], values: [])
      self.keys = keys
      self.values = []
      add_value(*values) unless values.empty?
    end

    def to_s
      "#{keys_string}=#{values.join(',')}"
    end

    def +(other)
      result = self.class.new
      result.keys = keys + other.keys
      result.values = values + other.values
      result
    end

    def add_value(*new_values)
      new_values.each do |new_value|
        values << ERB::Util.url_encode(new_value.to_s)
      end
    end

    private

    def primary_key
      keys.first
    end

    def nested_keys
      keys[1..-1]
    end

    def keys_string
      "#{keys.first}#{nested_keys_string}"
    end

    def nested_keys_string
      nested_keys.map { |k| "[#{k}]" }.join
    end
  end
end
