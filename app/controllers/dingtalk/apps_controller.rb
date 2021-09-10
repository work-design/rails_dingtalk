module Dingtalk
  class AppsController < BaseController
    before_action :set_app, only: [:login]
    before_action :set_normal_app, only: [:info]

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
      @app = App.where(type: ['Dingtalk::NewApp', 'Dingtalk::SaasApp']).find_by(app_key: params[:app_key])
    end

    def set_normal_app
      @app = NormalApp.find_by(app_key: params[:app_key])
    end

  end
end
