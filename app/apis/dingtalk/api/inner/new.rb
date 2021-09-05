module Dingtalk::Api
  module Inner::New
    BASE = 'https://api.dingtalk.com/'

    def getuserinfo(union_id)
      get "v1.0/contact/users/#{union_id}"
    end

  end
end
