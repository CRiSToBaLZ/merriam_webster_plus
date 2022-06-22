require "test_helper"

class ThesaurusEntryTest < Minitest::Test
  def setup
    VCR.use_cassette("main_entry_thesaurus") do
      @api_entry = MerriamWebsterPlus::Client.new(word: "affect", title: :collegiate_thesaurus).api_entries.first
    end
    @main_entry = MerriamWebsterPlus::ThesaurusEntry.new(api_entry: @api_entry).main_entry
  end

  def test_main_entry_thesaurus
    assert_equal "affect", @main_entry[:word]
    assert_equal "verb", @main_entry[:class]
    assert_nil @main_entry[:audio]
    assert_kind_of Array, @main_entry[:senses]
    assert_equal 2, @main_entry[:senses].size
    assert_equal "a7c65c54-3bb4-4afd-8db3-3e0e6586eade", @main_entry[:uuid]
    assert_equal "bf6a5469-7543-4c5b-89c0-94b57680236b", @main_entry[:target_uuid]
  end
end
