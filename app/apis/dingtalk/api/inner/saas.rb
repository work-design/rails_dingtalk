module Dingtalk::Api
  module Inner::Saas

    def getuserinfo(code)
      r = post '/rpc/oauth2/dingtalk_app_user.json', auth_code: code

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

      r = post '/mozi/employee/get_by_mobile', **payload

      if r.is_a? Hash
        r.dig('content', 'data')
      else
        r
      end
    end

    def text_notification(receiver_ids = [], text = '')
      payload = {
        receiverIds: Array(receiver_ids).join(','),
        tenantId: app.tenant_id,
        msg: {
          msgtype: 'text',
          text: {
            content: text
          }
        }
      }

      r = post '/message/workNotification', **payload

      if r.is_a? Hash
        r.dig('content', 'data')
      else
        r
      end
    end

  end
end
