module Dingtalk
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :agent_id, :string
      attribute :app_key, :string
      attribute :app_secret, :string
      attribute :corp_id, :string
      attribute :access_token, :string
      attribute :access_token_expires_at, :datetime
    end

    def api
      return @api if defined? @api
      @api = Api::Base.new(self)
    end

  end
end
