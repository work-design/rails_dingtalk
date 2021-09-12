require 'httpx'
require 'http/form_data'

module Dingtalk
  class HttpClient
    attr_reader :http

    def initialize
      @http = HTTPX.with(**RailsDingtalk.config.httpx)
    end

    def get(path, headers: {}, params: {}, base: nil, **options)
      headers['Accept'] ||= 'application/json'
      url = base + path

      response = @http.with_headers(headers).get(url, params: params)
      parse_response(response, options[:as])
    end

    def post(path, payload = {}, headers: {}, params: {}, base: nil, **options)
      headers['Accept'] ||= 'application/json'
      headers['Content-Type'] ||= 'application/json'
      url = base + path

      opts = {
        params: params,
        headers: headers
      }
      opts.merge!(body: payload) if payload.present?

      response = @http.with_headers(headers).post(url, **opts)
      binding.b

      parse_response(response, options[:as])
    end

    def post_file(path, file, headers: {}, params: {}, base: nil, **options)
      headers['Accept'] ||= 'application/json'
      url = base + path

      form_file = file.is_a?(HTTP::FormData::File) ? file : HTTP::FormData::File.new(file)
      response = @http.plugin(:multipart).with_headers(headers).post(
        url,
        params: params,
        form: { media: form_file }
      )
      parse_response(response, options[:as])
    end

    private
    def parse_response(response, parse_as)
      if response.status != 200
        Rails.logger.debug response.body.to_s
        raise "Request get fail, response status #{response.status}"
      end

      content_type = response.content_type.mime_type
      body = response.body.to_s
      Rails.logger.debug "body: #{body}"

      if content_type =~ /image|audio|video/
        data = Tempfile.new('tmp')
        data.binmode
        data.write(body)
        data.rewind
        return data
      elsif content_type =~ /html|xml/
        data = Hash.from_xml(body)
      else
        data = JSON.parse body.gsub(/[\u0000-\u001f]+/, '')
      end

      case data['errcode']
      when 0 # for request didn't expect results
        data
        # 42001: access_token timeout
        # 40014: invalid access_token
        # 40001, invalid credential, access_token is invalid or not latest hint
        # 48001, api unauthorized hint, should not handle here # GH-230
      when 42001, 40014, 40001, 41001
        raise Dingtalk::AccessTokenExpiredError
        # 40029, invalid code for mp # GH-225
        # 43004, require subscribe hint # GH-214
      when 2
        raise Dingtalk::ResponseError.new(data['errcode'], data['errmsg'])
      else
        data
      end
    end

  end
end
