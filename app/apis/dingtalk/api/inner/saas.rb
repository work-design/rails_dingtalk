module Dingtalk::Api
  module Inner::Saas
    #BASE = 'https://openplatform.dg-work.cn'
    BASE = 'https://openplatform-pro.ding.zj.gov.cn'

    def getuserinfo(code)
      r = post '/rpc/oauth2/dingtalk_app_user.json', auth_code: code, base: BASE

      if r.is_a? Hash
        r.dig('content', 'data')
      else
        r
      end
    end

    def get_employee_code(mobile)
      payload = {
        areaCode: '86',
        namespace: 'local',
        tenantId: app.tenant_id,
        mobile: mobile
      }

      r = post '/mozi/employee/get_by_mobile', payload, base: BASE

      if r.is_a? Hash
        r.dig('content', 'data')
      else
        r
      end
    end

  end
end
