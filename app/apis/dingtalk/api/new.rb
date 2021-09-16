module Dingtalk::Api
  class New < Base
    include Inner::New

    def token
      payload = {
        appKey: app.app_key,
        appSecret: app.app_secret,
      }
      r = @client.post 'v1.0/oauth2/accessToken', payload.to_json, base: app.base_url
      {
        'access_token' => r['accessToken'],
        'expires_in' => r['expireIn']
      }
    end

    protected
    def with_access_token(method, path, params = {}, headers = {}, payload = {}, tries = 2)
      app.refresh_access_token unless app.access_token_valid?
      yield params, headers.merge!(Authorization: "Bearer #{app.access_token}", 'x-acs-dingtalk-access-token': app.access_token)
    rescue => e
      Rails.logger.debug e.full_message
      app.refresh_access_token
      retry unless (tries -= 1).zero?
    end

  end
end
