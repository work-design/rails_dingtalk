module Dingtalk::Api
  module New
    BASE = 'https://api.dingtalk.com/'

    def getuserinfo(union_id)
      r = get "v1.0/contact/users/#{union_id}"
      r['result']
    end

  end
end
