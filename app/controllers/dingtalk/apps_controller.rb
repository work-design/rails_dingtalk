module Dingtalk
  class AppsController < BaseController
    before_action :set_app, only: [:login]
    before_action :set_app_by_corp, only: [:info]

    def info
      result = @app.xx(params[:code])
      render json: result
    end

    def login
      @dingtalk_user = @app.generate_user(params[:code])
      if @oauth_user.account.nil? && current_account
        @oauth_user.account = current_account
      end
      @oauth_user.save

      if @oauth_user.user
        login_by_oauth_user(@oauth_user)
        Com::SessionChannel.broadcast_to(params[:state], auth_token: current_authorized_token.token)
      else
        url_options = {}
        url_options.merge! params.except(:controller, :action, :id, :business, :namespace, :code, :state).permit!
        url_options.merge! host: URI(session[:return_to]).host if session[:return_to]
      end
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
