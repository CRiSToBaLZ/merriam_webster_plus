require "json"
require "httparty"

module MerriamWebsterPlus
  class Client
    MerriamWebsterAPIError = Class.new(StandardError)
    BadRequestError = Class.new(MerriamWebsterAPIError)
    UnauthorizedError = Class.new(MerriamWebsterAPIError)
    ForbiddenError = Class.new(MerriamWebsterAPIError)
    NotFoundError  = Class.new(MerriamWebsterAPIError)
    UnprocessableEntityError = Class.new(MerriamWebsterAPIError)
    ApiError = Class.new(MerriamWebsterAPIError)

    HTTP_OK_CODE = 200

    HTTP_BAD_REQUEST_CODE  = 400
    HTTP_UNAUTHORIZED_CODE = 401
    HTTP_FORBIDDEN_CODE      = 403
    HTTP_NOT_FOUND_CODE      = 404
    HTTP_UNPROCESSABLE_ENTITY_CODE = 429

    COLLEGIATE_DICTIONARY_ENDPOINT = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    COLLEGIATE_THESAURUS_ENDPOINT  = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"

    attr_reader :word, :title

    def initialize(word:, title:)
      @word  = railsy_parameterize(word)
      @title = title
    end

    def api_entries
      parsed_response
    end

    private

    def response
      @response ||= HTTParty.get("#{endpoint}#{word}?key=#{api_key}")
    end

    def parsed_response
      return JSON.parse(response.body, symbolize_names: true) if response_successful?

      raise error_class, "code: #{response.code}, message: #{response.message}, response: #{response.body}"
    end

    def error_class
      case response.code
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      else
        ApiError
      end
    end

    def response_successful?
      (response.code == HTTP_OK_CODE) && valid_json?(response.body)
    end

    def valid_json?(json)
      JSON.parse(json)
      true
    rescue JSON::ParserError => e
      false
    end

    def endpoint
      MerriamWebsterPlus::Client.const_get("#{title.upcase}_ENDPOINT")
    end

    def api_key
      ENV["#{title.upcase}_API_KEY"]
    end

    def railsy_parameterize(string)
      string.gsub(/[^a-z0-9\-_]+/i, "_").downcase
    end
  end
end
