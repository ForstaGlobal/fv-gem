require 'spec_helper'

describe FV::HttpClient do
  it 'has custom normalizer' do
    expect(FV::HttpClient.default_options[:query_string_normalizer])
      .not_to be_nil
  end

  it 'does not affect default HTTParty normalizer' do
    expect(HTTParty::Basement.default_options[:query_string_normalizer])
      .to be_nil
  end
end
