module Dingtalk::Api
  module User
    BASE = 'https://oapi.dingtalk.com/'

    def getuserinfo(code)
      post 'topapi/v2/user/getuserinfo', code: code
    end

  end
end
