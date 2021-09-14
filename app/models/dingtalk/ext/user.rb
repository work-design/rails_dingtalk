module Dingtalk
  module Ext::User
    extend ActiveSupport::Concern

    included do
      attribute :employee_code, :string
    end

    def sync_employee_code(mobile, tenant_id, app_key)
      app = SaasApp.find_by(app_key: app_key)
      info = app.api.get_employee_code(mobile, tenant_id)
      self.employee_code = info['employeeCode']
      self
    end

  end
end

