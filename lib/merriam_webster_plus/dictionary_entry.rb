require "merriam_webster_plus/dictionary_sense"

module MerriamWebsterPlus
  class DictionaryEntry
    AUDIO_MP3_ENDPOINT = "https://media.merriam-webster.com/audio/prons/en/us/mp3/"

    attr_reader :api_entry, :sense_parser

    def initialize(api_entry:)
      @api_entry = api_entry
      title_post_initialize
    end

    def main_entry
      {
        word: headword,
        class: word_class,
        audio: audio,
        senses: senses,
        uuid: uuid,
        target_uuid: target_uuid
      }
    end

    private

    def title_post_initialize
      @sense_parser = DictionarySense
    end

    def headword
      remove_non_letters(headword_information&.dig(:hw))
    end

    def word_class
      functional_label
    end

    def audio
      ("#{AUDIO_MP3_ENDPOINT}#{audio_subdirectory}/#{audio_filename}.mp3" if audio_filename)
    end

    def uuid
      entry_metadata[:uuid]
    end

    def target_uuid
      entry_metadata&.dig(:target, :tuuid)
    end

    def entry_metadata
      api_entry[:meta]
    end

    def headword_information
      api_entry[:hwi]
    end

    def functional_label
      api_entry[:fl]
    end

    def definition_section
      api_entry[:def]
    end

    def short_definition
      api_entry[:shortdef]
    end

    def senses
      return unless definition_section

      senses = []
      sense_sequence.each_with_index do |sense_group, index|
        senses << primary_sense(sense_group, index)
      end
      senses.first(3)
    end

    def primary_sense(sense_group, index)
      ["#{index + 1}".to_i,
       sense_parser.new(definition: definition(index), sense_group: sense_group).primary_sense]
    end

    def definition(index_num)
      short_definition&.dig(index_num)&.chomp(": such as")&.chomp(":")
    end

    def sense_sequence
      return parenthesized_sense_sequence if parenthesized_sense_sequence?

      definition_section&.dig(0, :sseq)
    end

    def parenthesized_sense_sequence
      definition_section&.dig(0, :sseq, 0, 0, 1)
    end

    def parenthesized_sense_sequence?
      definition_section&.dig(0, :sseq, 0, 0, 0) == "pseq"
    end

    def audio_filename
      headword_information&.dig(:prs, 0, :sound, :audio)
    end

    def audio_subdirectory
      if audio_filename.start_with?("bix")
        "bix"
      elsif audio_filename.start_with?("gg")
        "gg"
      elsif audio_filename.chr.match?((/[^a-z ]/i))
        "number"
      else
        audio_filename.chr
      end
    end

    def remove_non_letters(string)
      string&.gsub(/[^a-z ]/i, "")
    end
  end
end
