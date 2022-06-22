require "merriam_webster_plus/dictionary_entry"
require "merriam_webster_plus/thesaurus_sense"

module MerriamWebsterPlus
  class ThesaurusEntry < DictionaryEntry
    private

    def title_post_initialize
      @sense_parser = ThesaurusSense
    end
  end
end
