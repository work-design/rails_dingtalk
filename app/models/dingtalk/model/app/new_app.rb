module Dingtalk
  module Model::App::NewApp

    def api
      return @api if defined? @api
      @api = Api::New.new(self)
    end

  end
end
