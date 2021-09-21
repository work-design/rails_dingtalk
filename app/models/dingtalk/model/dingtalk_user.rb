module Dingtalk
  module Model::DingtalkUser
    extend ActiveSupport::Concern

    included do
      attribute :uid, :string
      attribute :unionid, :string, index: true
      attribute :appid, :string
      attribute :name, :string
      attribute :avatar_url, :string
      attribute :state, :string
      attribute :access_token, :string
      attribute :expires_at, :datetime
      attribute :refresh_token, :string
      attribute :extra, :json, default: {}
      attribute :identity, :string, index: true
      attribute :employee_code, :string

      belongs_to :new_app, foreign_key: :appid, primary_key: :app_key, optional: true
      belongs_to :saas_app, foreign_key: :appid, primary_key: :app_key, optional: true
    end

    def text_notification(text = '')
      account_id = extra.dig('accountId')
      saas_app.api.text_notification(account_id, text)
    end

  end
end
