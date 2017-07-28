module FV
  class HttpClient
    include HTTParty

    # Fix the HTTParty normalizer to create queries of the format
    # `?filter[a]=1,2&filter[b]=3&something=else`
    # `?filter[a][c]=1,2&filter[a]=9&filter[b]=3&something=else`
    query_string_normalizer(
      proc do |query|
        query.map do |key, value|
          UrlParam.construct_url_param(key, value).to_s
        end.join('&')
      end
    )
  end
end
