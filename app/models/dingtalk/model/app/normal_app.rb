module Dingtalk
  module Model::App::NormalApp
    extend ActiveSupport::Concern

    included do
      has_one :new_app, foreign_key: :app_key, primary_key: :app_key
    end

  end
end
