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
      #binding.break
      # wechat_user = wechat_users.find_or_initialize_by(uid: result['openid'])
      # wechat_user.assign_attributes result.slice('access_token', 'refresh_token', 'unionid')
      # wechat_user.expires_at = Time.current + result['expires_in'].to_i
      # wechat_user
    end

  end
end
