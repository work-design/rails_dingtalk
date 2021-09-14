module Dingtalk
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :name, :string
      attribute :agent_id, :string
      attribute :app_key, :string
      attribute :app_secret, :string
      attribute :corp_id, :string
      attribute :access_token, :string
      attribute :access_token_expires_at, :datetime
      attribute :jsapi_ticket, :string
      attribute :oauth2_state, :string
      attribute :jsapi_ticket_expires_at, :datetime
      attribute :tenant_id, :string, comment: '专有钉钉，租户ID'

      has_many :dingtalk_users, foreign_key: :appid, primary_key: :app_key
    end

    def api
      return @api if defined? @api
      @api = Api::Normal.new(self)
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

    def get_jsapi_ticket
      if jsapi_ticket_valid?
        jsapi_ticket
      else
        refresh_jsapi_ticket
      end
    end

    def jsapi_ticket_valid?
      return false unless jsapi_ticket_expires_at.acts_like?(:time)
      jsapi_ticket_expires_at > Time.current
    end

    def refresh_jsapi_ticket
      r = api.jsapi_ticket
      store_jsapi_ticket(r)
      jsapi_ticket
    end

    def store_jsapi_ticket(ticket_hash)
      self.jsapi_ticket = ticket_hash['ticket']
      self.jsapi_ticket_expires_at = Time.current + ticket_hash['expires_in'].to_i
      self.save
    end

  end
end
