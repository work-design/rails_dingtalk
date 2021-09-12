module RailsDingtalk
  include ActiveSupport::Configurable

  configure do |config|
    config.httpx = {
      ssl: {
        verify_mode: OpenSSL::SSL::VERIFY_NONE
      },
      debug: STDERR,
      debug_level: -1
    }
    config.ip = '127.0.0.1'
    config.mac = '78:7b:8a:dd:94:cc'
  end

end
