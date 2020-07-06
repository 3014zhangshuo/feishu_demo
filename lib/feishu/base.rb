# frozen_string_literal: true

module Feishu
  class Base
    APP_ID = "cli_9e7688822c74500c"
    APP_SECRET = "6HxTE1njNUCG5OsxEpESwdJbTGWpHnJT"

    def app_id
      APP_ID
    end

    def app_secret
      APP_SECRET
    end

    private

    def get(url, opts = {})
      request(:get, url, opts)
    end

    def post(url, opts = {})
      request(:post, url, opts)
    end

    def request(verb, url, opts = {})
      RestClient::Request.execute(
        method: verb,
        url: url,
        headers: opts[:headers],
        payload: opts[:payload]
      )
    end
  end
end
