module RailsDingtalk
  include ActiveSupport::Configurable

  configure do |config|
    config.httpx = {
      ssl: {
        verify_mode: OpenSSL::SSL::VERIFY_NONE
      }
    }
    config.ip = '192.168.0.1'
    config.mac = 'fa:16:3e:27:49:91'
  end

end
