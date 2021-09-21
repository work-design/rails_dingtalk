module Dingtalk::Api
  class Base
    attr_reader :app, :client

    def initialize(app)
      @app = app
      @client = Dingtalk::HttpClient.new
    end

    def token
      @client.get 'gettoken', params: { appkey: app.app_key, appsecret: app.app_secret }, base: app.base_url
    end

    def jsapi_ticket
      get 'get_jsapi_ticket', base: app.base_url
    end

    def get(path, params: {}, headers: {}, base: app.base_url, as: nil)
      with_access_token('get', path, params, headers, nil) do |processed_params, processed_headers|
        @client.get path, headers: processed_headers, params: processed_params, base: base, as: as
      end
    end

    def post(path, params: {}, headers: {}, base: app.base_url, **payload)
      with_access_token('post', path, params, headers, payload) do |processed_params, processed_headers|
        @client.post path, payload.to_json, headers: processed_headers, params: processed_params, base: base
      end
    end

    def post_file(path, file, params: {}, headers: {}, base: app.base_url)
      with_access_token('post', path, params, headers, nil) do |processed_params, processed_headers|
        @client.post_file path, file, headers: processed_headers, params: processed_params, base: base
      end
    end

    protected
    def with_access_token(method, path, params = {}, headers = {}, payload = {}, tries = 2)
      app.refresh_access_token unless app.access_token_valid?
      yield params.merge!(access_token: app.access_token), headers
    rescue => e
      Rails.logger.debug e.full_message
      app.refresh_access_token
      retry unless (tries -= 1).zero?
    end

  end
end
