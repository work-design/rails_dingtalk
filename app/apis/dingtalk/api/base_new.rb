module Dingtalk::Api
  class BaseNew < Base
    BASE = 'https://api.dingtalk.com/'

    def token
      @client.post 'v1.0/oauth2/userAccessToken', { clientId: app.app_key, clientSecret: app.app_secret }.to_json, base: BASE
    end

  end
end
