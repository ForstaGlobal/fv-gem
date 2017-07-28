describe FV::ApiError do
  describe '.from_raw' do
    it 'returns a specific instance of an error for the appropriate code' do
      raw_error_1 = {
        'title' => 'Validation Error',
        'detail' => 'that attribute is no good',
        'code' => '100',
        'status' => '422'
      }
      raw_error_2 = {
        'title' => 'Record Not Found',
        'detail' => 'Record does not exist',
        'code' => '404',
        'status' => '404'
      }
      error_1 = FV::ApiError.from_raw(raw_error_1)
      error_2 = FV::ApiError.from_raw(raw_error_2)

      expect(error_1).to be_kind_of(FV::ValidationError)
      expect(error_2).to be_kind_of(FV::RecordNotFoundError)
    end
  end

  describe '#code' do
    it 'returns code of error' do
      error = FV::ApiError.new(raw_error)

      expect(error.code).to eq(500)
    end
  end

  describe '#detail' do
    it 'returns detail of error' do
      error = FV::ApiError.new(raw_error)

      expect(error.detail).to eq('You forgot to cook bacon!')
    end
  end

  describe '#title' do
    it 'returns title of error' do
      error = FV::ApiError.new(raw_error)

      expect(error.title).to eq('Internal Server Error')
    end
  end

  describe '#status' do
    it 'returns status of error' do
      error = FV::ApiError.new(raw_error)

      expect(error.status).to eq(500)
    end
  end

  def raw_error
    {
      'code' => '500',
      'title' => 'Internal Server Error',
      'detail' => 'You forgot to cook bacon!',
      'status' => '500'
    }
  end
end
