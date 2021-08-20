module Dingtalk
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :agent_id, :string
      attribute :app_key, :string
      attribute :app_secret, :string
    end

  end
end
