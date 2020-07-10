# frozen_string_literal: true

# https://github.com/rest-client/rest-client/issues/397
module Feishu
  class HttpClient
    attr_reader :base

    def initialize(base, timeout = nil)
      @base = base
    end

    def get(path, opts = {})
      request(:get, path, opts)
    end

    def post(path, opts = {})
      request(:post, path, opts)
    end

    private

    def request(verb, path, opts = {})
      response = do_request(verb, path, opts)
      data = JSON.parse(response)
      case data['code']
      when 0
        data
      else
        raise ResponseError.new(data['code'], data['msg'])
      end
    end

    # TODO: replace rest-client
    def do_request(verb, path, opts = {})
      RestClient::Request.execute(
        method: verb,
        url: "#{base}#{path}",
        headers: opts[:headers],
        payload: opts[:payload].to_json
      )
    end
  end
end
