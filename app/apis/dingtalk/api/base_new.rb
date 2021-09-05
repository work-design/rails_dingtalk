module Dingtalk::Api
  class BaseNew < Base
    BASE = 'https://api.dingtalk.com/'

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

  end
end
