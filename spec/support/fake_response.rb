class FakeResponse
  attr_reader :body, :status

  def initialize(body:, status: 200)
    @body = body.to_json
    @status = status
  end

  def success?
    status >= 200 && status < 400
  end

  alias_method :code, :status
end
