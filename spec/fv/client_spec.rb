require 'spec_helper'

describe FV::Client do
  TEST_TOKEN = 'abcde'.freeze

  before(:each) do
    module FV::Test
      extend FV::Client
    end

    FV::Test.configure do |config|
      config.api_token = TEST_TOKEN
      config.api_url = 'https://test.url'
    end
  end

  describe '#request' do
    it 'raises error when no api_token is set' do
      FV::Test.configure do |config|
        config.api_token = nil
      end

      expect do
        FV::Test.request(:get, '/')
      end.to raise_error(FV::InvalidConfigurationError)
    end

    it 'sends requests' do
      stubbed_request = stub_request(:get, 'https://test.url')
      response = FV::Test.request(:get, '/')

      expect(stubbed_request).to have_been_requested
    end
  end
end
