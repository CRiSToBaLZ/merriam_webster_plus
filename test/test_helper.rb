# frozen_string_literal: true

require "minitest/autorun"
require "webmock"
require "vcr"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift File.expand_path("../fixtures", __dir__)
require "merriam_webster_plus"
require "merriam_webster_plus/client"
require "merriam_webster_plus/dictionary_entries"
require "merriam_webster_plus/dictionary_entry"
require "merriam_webster_plus/dictionary_sense"
require "merriam_webster_plus/thesaurus_entries"
require "merriam_webster_plus/thesaurus_entry"
require "merriam_webster_plus/dictionary_plus"
require "merriam_webster_plus/populator"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.define_cassette_placeholder("<COLLEGIATE_DICTIONARY_API_KEY>") { ENV["COLLEGIATE_DICTIONARY_API_KEY"] }
  config.define_cassette_placeholder("<COLLEGIATE_THESAURUS_API_KEY>") { ENV["COLLEGIATE_THESAURUS_API_KEY"] }
  config.allow_http_connections_when_no_cassette = false
end
