require "merriam_webster_plus/client"
require "merriam_webster_plus/thesaurus_entry"

module MerriamWebsterPlus
  class ThesaurusEntries < DictionaryEntries
    private

    def title_post_initialize
      @api_entries 		= MerriamWebsterPlus::Client.new(word: word, title: :collegiate_thesaurus).api_entries
      @entry_parser		= ThesaurusEntry
    end
  end
end
