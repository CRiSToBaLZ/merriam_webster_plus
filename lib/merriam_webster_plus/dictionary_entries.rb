require "merriam_webster_plus/client"
require "merriam_webster_plus/dictionary_entry"

module MerriamWebsterPlus
  class DictionaryEntries
    attr_reader :word, :api_entries, :entry_parser

    def initialize(word:)
      @word	= word
      title_post_initialize
    end

    def main_entries
      main_entries = []
      api_entries.each do |api_entry|
        main_entry = main_entry(api_entry)
        (main_entries << main_entry) if word_equals_entry_headword?(main_entry)
      end
      main_entries
    end

    private

    def title_post_initialize
      @api_entries	= MerriamWebsterPlus::Client.new(word: word, title: :collegiate_dictionary).api_entries
      @entry_parser	= DictionaryEntry
    end

    def main_entry(api_entry)
      entry_parser.new(api_entry: api_entry).main_entry if api_entry_valid?(api_entry)
    end

    def api_entry_valid?(api_entry)
      (api_entry.is_a? Hash)
    end

    def word_equals_entry_headword?(entry)
      entry && (word.downcase == entry[:word].downcase)
    end
  end
end
