module Dingtalk
  module Model::App::NewApp

    def api
      return @api if defined? @api
      @api = Api::New.new(self)
    end

    def oauth2_url(scope = 'openid corpid', state: SecureRandom.hex(16), **host_options)
      h = {
        client_id: app_key,
        redirect_uri: Rails.application.routes.url_for(controller: 'dingtalk/apps', action: 'login', id: id, **host_options),
        response_type: 'code',
        scope: scope,
        state: state,
        nonce: SecureRandom.hex(4)
      }

      logger.debug "\e[35m  Detail: #{h}  \e[0m"
      "https://login.dingtalk.com/oauth2/auth?#{h.to_query}"
    end

    def generate_user(code)
      h = {
        clientId: app_key,
        clientSecret: app_secret,
        code: code,
        grantType: 'authorization_code'
      }
      r = HTTPX.post 'https://api.dingtalk.com/v1.0/oauth2/userAccessToken', json: h
      result = JSON.parse(r.body.to_s)
      logger.debug result

      info = HTTPX.post 'https://api.dingtalk.com/v1.0/contact/users/me', headers: { 'x-acs-dingtalk-access-token': r['accessToken'] }
      logger.debug info
      #binding.break
      dingtalk_user = dingtalk_users.find_or_initialize_by(uid: info['openId'])
      dingtalk_user.access_token = r['accessToken']
      dingtalk_user.expires_at = Time.current + r['expireIn'].to_i
      dingtalk_user.refresh_token = r['refreshToken']
      dingtalk_user.unionid = info['unionId']
      dingtalk_user.name = info['nick']
      dingtalk_user.avatar_url = info['avatarUrl']
      dingtalk_user.identity = info['mobile']
      dingtalk_user.extra = info.slice('email', 'stateCode')
      dingtalk_user
    end

  end
end
