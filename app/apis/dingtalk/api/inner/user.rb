module Dingtalk::Api
  module Inner::User
    BASE = 'https://oapi.dingtalk.com/'

    def getuserinfo(code)
      r = post '/topapi/v2/user/getuserinfo', code: code
      if r.is_a? Hash
        r['result']
      else
        r
      end
    end

  end
end
