module Dingtalk
  class AppsController < BaseController
    before_action :set_app, only: [:info]

    def info
      result = @app.xx(params[:code])
      render json: result
    end

    def create
    end

    private
    def set_app
      @app = NormalApp.find_by corp_id: params[:corp_id]
    end

  end
end
