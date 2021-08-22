module Dingtalk
  class AppsController < BaseController
    before_action :set_app, only: [:login]

    def info
      result = @app.getuserinfo(params[:code])
      render json: result
    end

    def create
    end

    private
    def set_app
      @app = App.find_by corp_id: params[:corp_id]
    end

  end
end
