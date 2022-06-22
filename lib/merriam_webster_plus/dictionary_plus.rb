require "merriam_webster_plus/dictionary_entries"
require "merriam_webster_plus/thesaurus_entries"
require "merriam_webster_plus/entry_audio_merger"
require "merriam_webster_plus/primary_entry_finder"

module MerriamWebsterPlus
  class DictionaryPlus
    attr_reader :word, :thesaurus_entries, :dictionary_entries, :entry_audio_merger, :primary_entry_finder

    def initialize(word:)
      @word	= word
      @thesaurus_entries 		= MerriamWebsterPlus::ThesaurusEntries.new(word: word).main_entries
      @dictionary_entries 	= MerriamWebsterPlus::DictionaryEntries.new(word: word).main_entries
      @entry_audio_merger		= MerriamWebsterPlus::EntryAudioMerger
      @primary_entry_finder 	= PrimaryEntryFinder
    end

    def primary_entry
      primary_entry_with_audio if entries.any?
    end

    def entries
      thesaurus_entries.any? ? thesaurus_entries_with_audio : dictionary_entries_with_audio
    end

    private

    def thesaurus_entries_with_audio
      entry_audio_merger.new(dst_entries: thesaurus_entries, src_entries: dictionary_entries).merged_entries
    end

    def dictionary_entries_with_audio
      entry_audio_merger.new(dst_entries: dictionary_entries, src_entries: dictionary_entries).merged_entries
    end

    def primary_entry_with_audio
      primary_entry_finder.new(primary_src_entries: thesaurus_entries_with_audio,
                               secondary_src_entries: dictionary_entries_with_audio,
                               tertiary_src_entries: entries).primary_entry
    end

    def railsy_blank(object)
      object.nil? || object.empty?
    end
  end
end
