module Dingtalk::Api
  module Inner::Saas
    BASE = 'https://openplatform.dg-work.cn/'

    def getuserinfo(code)
      payload = {
        auth_code: code
      }
      headers = sign_access_header('POST', '/gettoken.json', payload)
      r = post 'rpc/oauth2/dingtalk_app_user.json', headers: headers, base: BASE

      binding.b
      if r.is_a? Hash
        r['result']
      else
        r
      end
    end

  end
end
