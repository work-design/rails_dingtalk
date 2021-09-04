module Dingtalk::Model
  module App::NewApp

    def api
      return @api if defined? @api
      @api = Api::BaseNew.new(self)
    end

  end
end
