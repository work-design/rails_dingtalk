module Dingtalk
  module Model::App::SaasApp
    extend ActiveSupport::Concern

    included do
    end

    def api
      return @api if defined? @api
      @api = Api::Saas.new(self)
    end

    def generate_user(code)
      info = api.getuserinfo(code)
      return unless info.is_a?(Hash)
      dingtalk_user = dingtalk_users.find_or_initialize_by(uid: info['openid'])
      dingtalk_user.name = info['nickNameCn']
      dingtalk_user.identity = info['account']
      dingtalk_user.employee_code = info['employeeCode']
      dingtalk_user.extra = info.slice('clientId', 'lastName', 'realmId', 'realmName', 'tenantUserId', 'accountId', 'tenantId', 'tenantName', 'referId', 'namespace')
      dingtalk_user
    end

  end
end
