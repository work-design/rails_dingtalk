module Dingtalk::Api
  class New < Base
    BASE = 'https://api.dingtalk.com/'
    include Inner::New

    def token
      payload = {
        appKey: app.app_key,
        appSecret: app.app_secret,
      }
      r = @client.post 'v1.0/oauth2/accessToken', payload.to_json, base: BASE
      {
        'access_token' => r['accessToken'],
        'expires_in' => r['expireIn']
      }
    end

    def base_host
      BASE
    end

    def get(path, params: {}, headers: {}, base: base_host, as: nil)
      with_access_token(headers) do |with_token_headers|
        @client.get path, headers: with_token_headers, params: params, base: base, as: as
      end
    end

    def post(path, params: {}, headers: {}, base: base_host, **payload)
      with_access_token(headers) do |with_token_headers|
        @client.post path, payload.to_json, headers: with_token_headers, params: params, base: base
      end
    end

    def post_file(path, file, params: {}, headers: {}, base: base_host)
      with_access_token(headers) do |with_token_headers|
        @client.post_file path, file, headers: with_token_headers, params: params, base: base
      end
    end

    protected
    def with_access_token(headers = {}, tries = 2)
      app.refresh_access_token unless app.access_token_valid?
      yield headers.merge!(
        Authorization: "Bearer #{app.access_token}",
        'x-acs-dingtalk-access-token': app.access_token
      )
    rescue => e
      Rails.logger.debug e.full_message
      app.refresh_access_token
      retry unless (tries -= 1).zero?
    end

  end
end
