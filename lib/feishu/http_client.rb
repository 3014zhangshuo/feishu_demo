# frozen_string_literal: true

# https://github.com/rest-client/rest-client/issues/397
module Feishu
  class HttpClient
    attr_reader :base

    def initialize(base, timeout = nil)
      @base = base
    end

    def get(path, **opts)
      request(:get, path, opts)
    end

    def post(path, **opts)
      request(:post, path, opts)
    end

    private

    def default_headers
      { content_type: :json, accept: :json }
    end

    def request(verb, path, **opts)
      response = do_request(verb, path, opts)
      response_handler(response)
    end

    def response_handler(response)
      data = JSON.parse(response)
      case data['code']
      when 0
        data
      else
        raise ResponseError.new(data['code'], data['msg'])
      end
    end

    # TODO: replace rest-client
    def do_request(verb, path, **opts)
      RestClient::Request.execute(
        method: verb,
        url: "#{base}#{path}",
        headers: request_headers(opts[:headers], opts[:overwrite_headers]),
        payload: request_payload(opts[:payload], opts[:payload_as_original])
      )
    end

    def request_headers(headers, overwrite)
      return headers if overwrite

      default_headers.merge(headers || {})
    end

    def request_payload(payload, as_original)
      return if payload.nil?
      return payload if as_original

      payload.to_json
    end
  end
end
