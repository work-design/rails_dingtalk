module Dingtalk::Api
  module Base
    BASE = 'https://oapi.dingtalk.com/'
    attr_reader :app, :client

    def initialize(app)
      @app = app
      @client = HttpClient.new
    end

  end
end
