module Dingtalk
  module Model::App::SaasApp
    extend ActiveSupport::Concern

    included do
    end

    def api
      return @api if defined? @api
      @api = Api::Saas.new(self)
    end

    def xx(code)
      result = api.getuserinfo(code)
      new_app.api.getuserinfo(result['unionid'])
    end

    def generate_user(code)
      r = api.getuserinfo(code)
    end

  end
end
