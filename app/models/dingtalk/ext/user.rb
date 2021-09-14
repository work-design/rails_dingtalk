module Dingtalk
  module Ext::User
    extend ActiveSupport::Concern

    included do
      attribute :employee_code, :string
    end

    def sync_employee_code(mobile, app_key = nil)
      app = SaasApp.find_by(app_key: app_key) || SaasApp.first
      info = app.api.get_employee_code(mobile)
      self.employee_code = info['employeeCode']
      self
    end

  end
end

