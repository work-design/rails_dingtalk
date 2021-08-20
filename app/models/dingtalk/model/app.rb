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

    def refresh_access_token
      r = api.token
      if r['access_token']
        store_access_token(r)
      else
        logger.debug "\e[35m  #{r['errmsg']}  \e[0m"
      end
    end

    def store_access_token(token_hash)
      self.access_token = token_hash['access_token']
      self.access_token_expires_at = Time.current + token_hash['expires_in'].to_i
      self.save
    end

    def access_token_valid?
      return false unless access_token_expires_at.acts_like?(:time)
      access_token_expires_at > Time.current
    end

  end
end
