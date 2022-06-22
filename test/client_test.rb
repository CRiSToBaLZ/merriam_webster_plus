require "test_helper"
require "minitest/stub_const"

class ClientTest < Minitest::Test
  def setup
    VCR.use_cassette("valid_api_entries") do
      @valid_api_entries	= client.new(word: "affect", title: :collegiate_dictionary).api_entries
    end

    @valid_api_entry	= @valid_api_entries.first

    VCR.use_cassette("invalid_api_entries") do
      @invalid_api_entries	= client.new(word: "431351", title: :collegiate_dictionary).api_entries
    end
  end

  def test_valid_api_entries
    assert_kind_of Array, @valid_api_entries
    @valid_api_entries.each do |entry|
      assert_kind_of Hash, entry
    end
  end

  def test_valid_entry
    assert @valid_api_entry.key?(:meta)
    assert @valid_api_entry.key?(:hom)
    assert @valid_api_entry.key?(:hwi)
    assert @valid_api_entry.key?(:fl)
    assert @valid_api_entry.key?(:def)
    assert @valid_api_entry.key?(:shortdef)
  end

  def test_invalid_api_entries
    assert_kind_of Array, @invalid_api_entries
    assert_empty @invalid_api_entries
  end

  def test_empty_api_entries
    assert_raises(MerriamWebsterPlus::Client::ApiError) do
      VCR.use_cassette("empty_api_entries") do
        client.new(word: "", title: :collegiate_dictionary).api_entries
      end
    end
  end

  def test_invalid_endpoint_api_entries
    assert_raises(MerriamWebsterPlus::Client::NotFoundError) do
      MerriamWebsterPlus::Client.stub_const(:COLLEGIATE_DICTIONARY_ENDPOINT,
                                            "https://www.dictionaryapi.com/api/aut_caesar_aut_nihil/") do
        VCR.use_cassette("invalid_endpoint_api_entries") do
          client.new(word: "batch", title: :collegiate_dictionary).api_entries
        end
      end
    end
  end

  private

  def client
    MerriamWebsterPlus::Client
  end
end
