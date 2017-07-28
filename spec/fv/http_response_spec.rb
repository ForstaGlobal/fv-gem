require 'support/fake_response'

describe FV::HttpResponse do
  describe '#successful?' do
    it 'true when response is successful' do
      fake_response = FakeResponse.new(body: { test: true }, status: 200)
      response = FV::HttpResponse.new(fake_response)

      expect(response).to be_successful
    end

    it 'false when response is not successful' do
      fake_response = FakeResponse.new(body: { test: true }, status: 400)
      response = FV::HttpResponse.new(fake_response)

      expect(response).to_not be_successful
    end
  end

  describe '#data' do
    it 'returns data member returned from API' do
      json_body = {
        'data' => {
          'id' => '1',
          'type' => 'timestamp_requests',
          'attributes' => {
            'name' => 'Johnny'
          }
        }
      }
      fake_response = FakeResponse.new(body: json_body)
      response = FV::HttpResponse.new(fake_response)

      data = response.data

      expect(data).to eq(json_body['data'])
    end

    it 'returns nil if there are errors' do
      json_body = {
        'errors' => [{
          'title' => 'test',
          'detail' => 'test'
        }]
      }
      fake_response = FakeResponse.new(body: json_body, status: 422)
      response = FV::HttpResponse.new(fake_response)

      data = response.data

      expect(data).to be_nil
    end
  end

  describe '#errors' do
    it 'returns array of errors when there are errors' do
      json_body = {
        'errors' => [{
          'title' => 'test',
          'detail' => 'test',
          'code' => '404'
        }, {
          'title' => 'test2',
          'detail' => 'test2',
          'code' => '403'
        }]
      }
      fake_response = FakeResponse.new(body: json_body, status: 422)
      response = FV::HttpResponse.new(fake_response)

      errors = response.errors

      expect(errors.size).to eq(2)
      expect(errors[0]).to(
        be_kind_of(FV::RecordNotFoundError)
      )
      expect(errors[1]).to be_kind_of(FV::ForbiddenError)
    end

    it 'returns empty array when there are no errors' do
      json_body = { 'data' => {}}
      fake_response = FakeResponse.new(body: json_body)
      response = FV::HttpResponse.new(fake_response)

      errors = response.errors

      expect(errors).to be_empty
    end

    it 'constructs error from code when response is not json api' do
      json_body = {
        'error' => 'Not json api'
      }
      fake_response = FakeResponse.new(body: json_body, status: 401)
      response = FV::HttpResponse.new(fake_response)

      errors = response.errors

      expect(errors.size).to eq(1)
      expect(errors[0]).to(
        be_kind_of(FV::AuthenticationError)
      )
    end
  end
end
