require "test_helper"

class PopulatorTest < Minitest::Test
  def setup
    VCR.use_cassette("word_medley_primary_entry_population") do
      MerriamWebsterPlus::Populator.new(
        lookupper: MerriamWebsterPlus::DictionaryPlus,
        src_dir: File.expand_path("test/csvs/test.csv"),
        dst_dir: File.expand_path("test/csvs/test_out.csv")
      ).populate
    end
  end

  # This acts as end-to-end integration test with widespread coverage of common usages and random edge cases.
  def test_word_medley_primary_entry_population
    csv = CSV.open("test/csvs/test_out.csv").read
    assert_equal %w[word part_of_speech definition example_sentence audio],
                 csv[0]

    assert_equal ["Internet", "noun", "an electronic communications network that connects computer networks and organizational computer facilities around the world —used with the except when being used attributively", "doing research on the Internet", "https://media.merriam-webster.com/audio/prons/en/us/mp3/i/inter01s.mp3"],
                 csv[1]

    assert_equal ["reversible", "adjective", "capable of being reversed or of reversing", "a reversible chemical reaction", "https://media.merriam-webster.com/audio/prons/en/us/mp3/r/revers05.mp3"],
                 csv[2]

    assert_equal ["yearn", "verb", "to long persistently, wistfully, or sadly", "yearns to make a difference", "https://media.merriam-webster.com/audio/prons/en/us/mp3/y/yearn001.mp3"],
                 csv[3]

    assert_equal ["acre", "noun", "any of various units of area; specifically : a unit in the U.S. and England equal to 43,560 square feet (4047 square meters)", "acres of free publicity", "https://media.merriam-webster.com/audio/prons/en/us/mp3/a/acre0001.mp3"],
                 csv[4]

    assert_equal ["contrast", "noun", "the quality or state of being different", "the contrast between the two approaches to the problem of overeating could not be greater", "https://media.merriam-webster.com/audio/prons/en/us/mp3/c/contra64.mp3"],
                 csv[5]

    assert_equal ["superior", "adjective", "having a feeling of superiority that shows itself in an overbearing attitude", "that superior sportscaster lets it be known that he thinks all foreign baseball teams are second-rate", "https://media.merriam-webster.com/audio/prons/en/us/mp3/s/superi14.mp3"],
                 csv[6]

    assert_equal ["pardoned", "verb", "to cease to have feelings of anger or bitterness toward", "he eventually pardoned his sister after she apologized", nil],
                 csv[7]

    assert_equal ["salmon", "noun", "a large anadromous salmonid fish (Salmo salar) of the North Atlantic noted as a game and food fish —called also Atlantic salmon", nil, "https://media.merriam-webster.com/audio/prons/en/us/mp3/s/salmon01.mp3"],
                 csv[8]

    assert_equal ["fungi", "combining form", "fungus", "fungiform", nil],
                 csv[9]

    assert_equal ["Ferris wheel", "noun", "an amusement device consisting of a large upright power-driven wheel carrying seats that remain horizontal around its rim", nil, "https://media.merriam-webster.com/audio/prons/en/us/mp3/f/ferris01.mp3"],
                 csv[10]
  end
end
