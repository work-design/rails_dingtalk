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

      belongs_to :new_app, foreign_key: :appid, primary_key: :app_key
    end


  end
end
