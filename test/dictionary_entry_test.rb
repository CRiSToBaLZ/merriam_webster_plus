require "test_helper"

class DictionaryEntryTest < Minitest::Test
  def setup
    VCR.use_cassette("main_entry_dictionary") do
      @api_entry = MerriamWebsterPlus::Client.new(word: "affect", title: :collegiate_dictionary).api_entries.first
    end
    @main_entry = MerriamWebsterPlus::DictionaryEntry.new(api_entry: @api_entry).main_entry
  end

  def test_main_entry_dictionary
    assert_equal "affect", @main_entry[:word]
    assert_equal "verb", @main_entry[:class]
    assert_equal "https://media.merriam-webster.com/audio/prons/en/us/mp3/a/affect02.mp3", @main_entry[:audio]
    assert_kind_of Array, @main_entry[:senses]
    assert_equal 1, @main_entry[:senses].size
    assert_equal "e493a2b7-ba1f-469a-bb27-5d464108b09f", @main_entry[:uuid]
    assert_nil @main_entry[:target_uuid]
  end
end
