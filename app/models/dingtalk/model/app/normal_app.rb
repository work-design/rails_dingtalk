module Dingtalk
  module Model::App::NormalApp
    extend ActiveSupport::Concern

    included do
      has_one :new_app, foreign_key: :app_key, primary_key: :app_key
    end

    def xx(code)
      result = api.getuserinfo(code)
      new_app.api.getuserinfo(result['unionid'])
    end

  end
end
