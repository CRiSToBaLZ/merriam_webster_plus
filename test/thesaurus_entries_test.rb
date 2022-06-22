require "test_helper"

class ThesaurusEntriesTest < Minitest::Test
  def setup
    VCR.use_cassette("main_entries_thesaurus") do
      @main_entries = MerriamWebsterPlus::ThesaurusEntries.new(word: "affect").main_entries
    end
  end

  def test_main_entries_dictionary
    assert_kind_of Array, @main_entries
    @main_entries.each do |entry|
      assert_kind_of Hash, entry
    end

    assert_equal 2, @main_entries.size
  end
end
