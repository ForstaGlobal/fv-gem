describe FV::UrlParam do
  describe '.construct_url_param' do
    it 'handles simple params' do
      expect(FV::UrlParam.construct_url_param(:option, 5))
        .to eq('option=5')
      expect(FV::UrlParam.construct_url_param(:option, 'hi'))
        .to eq('option=hi')
      expect(FV::UrlParam.construct_url_param(:option, 'yo yo'))
        .to eq('option=yo%20yo')
    end

    it 'handles simple arrays' do
      expect(FV::UrlParam.construct_url_param(:option, [1, 5]))
        .to eq('option=1,5')
      expect(FV::UrlParam.construct_url_param(:option, [1]))
        .to eq('option=1')
      expect(FV::UrlParam.construct_url_param(:option, []))
        .to eq('option=')
    end

    it 'handles simple hashes' do
      expect(FV::UrlParam.construct_url_param(:filter, a: 'y'))
        .to eq('filter[a]=y')
      expect(FV::UrlParam.construct_url_param(:filter, a: 'y', b: 'z'))
        .to eq('filter[a]=y&filter[b]=z')
    end

    it 'handles nested hashes' do
      expect(FV::UrlParam.construct_url_param(:filter, {
        a: {
          a: 'x',
          b: {
            c: 1
          },
          d: 2
        }
      }))
        .to eq('filter[a][a]=x&filter[a][b][c]=1&filter[a][d]=2')
    end

    it 'handles combinations' do
      expect(FV::UrlParam.construct_url_param(:filter, {
        a: {
          a: ['x', 5],
          b: {
            c: [1, 2],
            d: 'y'
          }
        },
        e: [11, 12]
      })).to eq(
        'filter[a][a]=x,5&filter[a][b][c]=1,2&filter[a][b][d]=y&filter[e]=11,12'
      )
    end
  end
end
