module MerriamWebsterPlus
  class PrimaryEntryFinder
    attr_reader :primary_src_entries, :secondary_src_entries, :tertiary_src_entries

    def initialize(primary_src_entries:, secondary_src_entries:, tertiary_src_entries:)
      @primary_src_entries = primary_src_entries
      @secondary_src_entries = secondary_src_entries
      @tertiary_src_entries = tertiary_src_entries
    end

    def primary_entry
      first_complete_entry(primary_src_entries) ||
        first_complete_entry(secondary_src_entries) ||
        first_entry(tertiary_src_entries)
    end

    private

    def first_complete_entry(entries)
      entries.each do |entry|
        entry[:senses]&.each do |sense_section|
          sense = sense_section&.dig(1)
          return singled_entry(entry: entry, sense: sense) if !sense[:example].nil? && !sense[:definition].nil?
        end
      end
      nil
    end

    def first_entry(entries)
      singled_entry(entry: entries.first, sense: entries&.dig(0, :senses, 0)&.dig(1))
    end

    def singled_entry(entry:, sense:)
      { word: entry[:word],
        class: entry[:class],
        definition: sense&.dig(:definition),
        example: sense&.dig(:example),
        audio: entry[:audio] }
    end
  end
end
