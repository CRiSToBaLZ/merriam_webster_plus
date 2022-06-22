require "test_helper"

class DictionaryPlusTest < Minitest::Test
  def setup
    VCR.use_cassette("valid_dictionary_plus_lookup") do
      @valid_dictionary_plus_lookup = MerriamWebsterPlus::DictionaryPlus.new(word: "affect")
    end
    @valid_entries = @valid_dictionary_plus_lookup.entries
    @valid_primary_entry = @valid_dictionary_plus_lookup.primary_entry

    VCR.use_cassette("invalid_dictionary_plus_lookup") do
      @invalid_dictionary_plus_lookup = MerriamWebsterPlus::DictionaryPlus.new(word: "asdgkhjiga")
    end
    @invalid_entries = @invalid_dictionary_plus_lookup.entries
    @invalid_primary_entry = @invalid_dictionary_plus_lookup.primary_entry
  end

  def test_valid_entries
    assert_kind_of Array, @valid_entries
    @valid_entries.each do |entry|
      assert_kind_of Hash, entry
    end

    assert_equal 2, @valid_entries.size
  end

  def test_invalid_entries
    assert_kind_of Array, @invalid_entries
    assert_empty @invalid_entries
  end

  def test_valid_primary_entry
    assert_equal({ word: "affect",
                   class: "verb",
                   definition: "to act upon (a person or a person's feelings) so as to cause a response",
                   example: "their son claims that scary movies don't affect him in the least",
                   audio: "https://media.merriam-webster.com/audio/prons/en/us/mp3/a/affect02.mp3" },
                 @valid_primary_entry)
  end

  def test_invalid_primary_entry
    assert_nil @invalid_primary_entry
  end

  def test_word_not_in_thesaurus_primary_entry
    VCR.use_cassette("word_not_in_thesaurus_primary_entry") do
      @entry_1 = MerriamWebsterPlus::DictionaryPlus.new(word: "salmon").primary_entry
    end
    assert_equal({ word: "salmon",
                   class: "noun",
                   definition: "a large anadromous salmonid fish (Salmo salar) of the North Atlantic noted as a game and food fish —called also Atlantic salmon",
                   example: nil,
                   audio: "https://media.merriam-webster.com/audio/prons/en/us/mp3/s/salmon01.mp3" },
                 @entry_1)
  end

  def test_word_not_in_dictionary_primary_entry
    VCR.use_cassette("word_not_in_dictionary_primary_entry") do
      @entry_2 = MerriamWebsterPlus::DictionaryPlus.new(word: "pardoned").primary_entry
    end
    assert_equal({ word: "pardoned",
                   class: "verb",
                   definition: "to cease to have feelings of anger or bitterness toward",
                   example: "he eventually pardoned his sister after she apologized",
                   audio: nil },
                 @entry_2)
  end
end
