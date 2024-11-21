require "http/client"
require "json"
require "uri"
require "http_proxy"

module TelegramApi

  class ApiError < Exception
  end

  class NonTelegramApiError < ApiError
    getter res : HTTP::Client::Response
    def initialize(res : HTTP::Client::Response)
      super(res.body)
      @res = res
    end
  end
  
  class TelegramApiError < ApiError
    CODE_NOT_FOUND = 404

    getter body : JSON::Any
    def initialize(body : JSON::Any)
      super(body["description"].as_s)
      @body = body
    end
    def description      
      body["description"].as_s
    end
    def code
      body["error_code"].as_i
    end
  end

  class ApiResult(T)
    include JSON::Serializable
    include JSON::Serializable::Unmapped

    property ok : Bool
    property result : T
  end

end

class TelegramApi::ApiClient
  def initialize(token : String)
    @token = token
  end

  def use_proxy?
    if proxy_address = ENV["https_proxy"]?
      uri = URI.parse proxy_address
      if (host = uri.host) && (port = uri.port)
        HTTP::Proxy::Client.new(host, port)
      end
    end
  end

  private def get_client(uri)
    client = HTTP::Client.new(URI.parse uri)
    if proxy = use_proxy?
      client.proxy = proxy
    end
    client
  end

  private def send_request!(method : String, form : Hash)
    endpoint = "https://api.telegram.org/bot#{@token}/#{method}"
    get_client(endpoint).post(endpoint, form: form)
  end
  private def send_request!(method : String)
    endpoint = "https://api.telegram.org/bot#{@token}/#{method}"
    get_client(endpoint).post(endpoint)
  end
  private def send_request!(method : String, form : NamedTuple)
    endpoint = "https://api.telegram.org/bot#{@token}/#{method}"
    get_client(endpoint).post(
      endpoint, 
      headers: HTTP::Headers{
        "Content-Type" => "application/json"
      },
      body: form.to_json
    )
  end

  macro define_method(name, result_type)
    def {{name.id}}!(*args)
      res = send_request!("{{name.id}}", *args)
      if res.success?
        return ApiResult({{result_type}}).from_json(res.body).result
      else
        error = begin
          TelegramApiError.new(JSON.parse(res.body))
        rescue
          NonTelegramApiError.new(res)
        end

        raise error
      end
    end

    def {{name.id}}?(*args)
      begin
        {{name.id}}!(*args)
        return {true, Nil}
      rescue e
        return {false, e}
      end
    end
  end

end

require "./types/*"
require "./methods/*"
