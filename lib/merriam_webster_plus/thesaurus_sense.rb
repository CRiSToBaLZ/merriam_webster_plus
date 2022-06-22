module MerriamWebsterPlus
  class ThesaurusSense < DictionarySense
    def primary_sense
      {
        definition: definition,
        synonyms: synonyms,
        synonyms_and_near_synonyms: synonyms_and_near_synonyms,
        related_words: related_words,
        synonymous_phrases: synonymous_phrases,
        near_antonyms: near_antonyms,
        antonyms: antonyms,
        antonyms_and_near_antonyms: antonyms_and_near_antonyms,
        example: example_sentence
      }.compact
    end

    private

    def synonyms
      sense&.dig(:syn_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def synonyms_and_near_synonyms
      sense&.dig(:sim_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def related_words
      sense&.dig(:rel_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def synonymous_phrases
      sense&.dig(:phrase_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def near_antonyms
      sense&.dig(:near_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def antonyms
      sense&.dig(:ant_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end

    def antonyms_and_near_antonyms
      sense&.dig(:opp_list, 0)&.map { |word_obj| word_obj&.dig(:wd) }&.join(", ")
    end
  end
end
