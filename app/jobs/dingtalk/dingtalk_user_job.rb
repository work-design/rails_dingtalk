module Dingtalk
  class DingtalkUserJob < ApplicationJob

    def perform(agency)
      agency.store_info
    end

  end
end
