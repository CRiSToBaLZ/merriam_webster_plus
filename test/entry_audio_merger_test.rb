require "test_helper"

class EntryAudioMergerTest < Minitest::Test
  def setup
    VCR.use_cassette("heteronym_entries") do
      @heteronym_dst_entries = MerriamWebsterPlus::ThesaurusEntries.new(word: "affect").main_entries
      @heteronym_src_entries = MerriamWebsterPlus::DictionaryEntries.new(word: "affect").main_entries
    end
    @heteronym_merged_entries = MerriamWebsterPlus::EntryAudioMerger.new(dst_entries: @heteronym_dst_entries,
                                                                         src_entries: @heteronym_src_entries)
                                                                    .merged_entries

    VCR.use_cassette("non_heteronym_entries") do
      @non_heteronym_dst_entries = MerriamWebsterPlus::ThesaurusEntries.new(word: "beach").main_entries
      @non_heteronym_src_entries = MerriamWebsterPlus::DictionaryEntries.new(word: "beach").main_entries
    end
    @non_heteronym_merged_entries = MerriamWebsterPlus::EntryAudioMerger.new(dst_entries: @non_heteronym_dst_entries,
                                                                             src_entries: @non_heteronym_src_entries)
                                                                        .merged_entries
  end

  def test_heteronym_entries
    assert_equal "https://media.merriam-webster.com/audio/prons/en/us/mp3/a/affect02.mp3",
                 @heteronym_merged_entries[0][:audio]
    assert_equal "https://media.merriam-webster.com/audio/prons/en/us/mp3/a/affect01.mp3",
                 @heteronym_merged_entries[1][:audio]
  end

  def test_non_heteronym_entries
    single_audio = "https://media.merriam-webster.com/audio/prons/en/us/mp3/b/beach001.mp3"
    assert_equal single_audio, @non_heteronym_merged_entries[0][:audio]
    assert_equal single_audio, @non_heteronym_merged_entries[1][:audio]
  end
end
