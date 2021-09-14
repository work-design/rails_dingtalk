module Dingtalk
  class Admin::AppsController < Admin::BaseController

    def index
      @apps = App.page(params[:page])
    end

    private
    def app_permit_params
      [
        :type,
        :name,
        :corp_id,
        :agent_id,
        :tenant_id,
        :app_key,
        :app_secret
      ]
    end

  end
end
