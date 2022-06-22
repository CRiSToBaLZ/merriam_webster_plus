module MerriamWebsterPlus
  class DictionarySense
    attr_reader :definition, :sense_group

    def initialize(definition:, sense_group:)
      @definition = definition
      @sense_group = sense_group
    end

    def primary_sense
      {
        definition: definition,
        example: example_sentence
      }.compact
    end

    private

    def sense
      sense_group&.select { |sense| sense[0] == "sense" }&.first&.dig(1)
    end

    def example_sentence
      verbal_illustration unless lacking_letters?(verbal_illustration)
    end

    def defining_text_section
      sense&.dig(:dt)
    end

    def defining_text_section_usage_notes
      defining_text_section&.select { |section| section[0] == "uns" }&.dig(0, 1, 0)
    end

    def defining_text_section_supplemental_information_notes
      defining_text_section&.select { |section| section[0] == "snote" }&.dig(0, 1)
    end

    def verbal_illustration_section
      select_verbal_illustration_section(defining_text_section) ||
        select_verbal_illustration_section(defining_text_section_usage_notes) ||
        select_verbal_illustration_section(defining_text_section_supplemental_information_notes)
    end

    def select_verbal_illustration_section(containing_section)
      containing_section&.select { |section| section[0] == "vis" }&.last
    end

    def verbal_illustration
      verbal_illustration_section&.dig(1, 0, :t)&.gsub(/\{.*?\}/, "")&.strip
    end

    def lacking_letters?(string)
      string.nil? || string.to_s[/\p{L}/].nil?
    end
  end
end
