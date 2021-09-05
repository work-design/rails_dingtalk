module Dingtalk
  class AppsController < BaseController
    before_action :set_app, only: [:login]
    before_action :set_app_by_corp, only: [:info]

    def info
      result = @app.xx(params[:code])
      render json: result
    end

    def login
      @dingtalk_user = @app.generate_user(params[:authCode])
      @dingtalk_user.save
    end

    def create
    end

    private
    def set_app
      @app = App.find params[:id]
    end

    def set_app_by_corp
      @app = NormalApp.find_by corp_id: params[:corp_id]
    end

  end
end
