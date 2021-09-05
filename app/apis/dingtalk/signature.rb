module Dingtalk
  module Signature
    extend self

    def signature(secret, timestamp = (Time.current.to_f * 1000).round)
      raise ArgumentError, 'timestamp must in millis' if Math.log10(timestamp).ceil < 13

      origin_str = [timestamp, secret].join("\n")
      signature_str = OpenSSL::HMAC.digest('SHA256', secret, origin_str)
      signature_str_base64 = Base64.strict_encode64(signature_str)

      URI.encode_www_form_component(signature_str_base64)
    end

  end
end
