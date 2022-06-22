require "test_helper"

class ThesaurusSenseTest < Minitest::Test
  def setup
    definition = "to act upon (a person or a person's feelings) so as to cause a response"
    sense_group = sense_group_snippet

    @valid_primary_sense =
      MerriamWebsterPlus::ThesaurusSense.new(definition: definition, sense_group: sense_group).primary_sense
  end

  def test_valid_main_sense_thesaurus
    assert_equal "to act upon (a person or a person's feelings) so as to cause a response",
                 @valid_primary_sense[:definition]
    assert_equal "impact, impress, influence, move, reach, strike, sway, tell (on), touch",
                 @valid_primary_sense[:synonyms]
    assert_nil @valid_primary_sense[:synonyms_and_near_synonyms]
    assert_equal "carry away, dazzle, enrapture, entrance, enthrall, ravish, transport",
                 @valid_primary_sense[:related_words]
    assert_equal "get to", @valid_primary_sense[:synonymous_phrases]
    assert_equal "bore, jade, pall, tire, weary", @valid_primary_sense[:near_antonyms]
    assert_nil @valid_primary_sense[:antonyms]
    assert_nil @valid_primary_sense[:antonyms_and_near_antonyms]
    assert_equal "their son claims that scary movies don't affect him in the least", @valid_primary_sense[:example]
  end

  private

  def sense_group_snippet
    [["sense", { sn: "1", dt: [["text", "to act upon (a person or a person's feelings) so as to cause a response "],
                               ["vis",
                                [{ t: "their son claims that scary movies don't {it}affect{/it} him in the least" }]]], syn_list: [[{ wd: "impact" },
                                                                                                                                    { wd: "impress" }, { wd: "influence" }, { wd: "move" }, { wd: "reach" }, { wd: "strike" }, { wd: "sway" }, { wd: "tell (on)" },
                                                                                                                                    { wd: "touch" }]], rel_list: [[{ wd: "carry away" }, { wd: "dazzle" }, { wd: "enrapture" }, { wd: "entrance" }, { wd: "enthrall",
                                                                                                                                                                                                                                                      wvrs: [{
                                                                                                                                                                                                                                                        wvl: "or", wva: "enthral"
                                                                                                                                                                                                                                                      }] }, { wd: "ravish" }, { wd: "transport" }], [{ wd: "bias" }, { wd: "color" }],
                                                                                                                                                                  [{ wd: "inspire" }, { wd: "stir" }], [{ wd: "engage" }, { wd: "interest" }, { wd: "involve" }, { wd: "penetrate" },
                                                                                                                                                                                                        { wd: "pierce" }], [{ wd: "afflict" }, { wd: "agitate" }, { wd: "bother" }, { wd: "concern" }, { wd: "discomfort" },
                                                                                                                                                                                                                            { wd: "discompose" }, { wd: "disquiet" }, { wd: "distress" }, { wd: "disturb" }, { wd: "fluster" }, { wd: "harass" },
                                                                                                                                                                                                                            { wd: "harry" }, { wd: "perturb" }, { wd: "pester" }, { wd: "plague" }, { wd: "smite" }, { wd: "strain" }, { wd: "stress" },
                                                                                                                                                                                                                            { wd: "trouble" }, { wd: "try" }, { wd: "upset" }, { wd: "worry" }, { wd: "wring" }], [{ wd: "allure" }, { wd: "attract" },
                                                                                                                                                                                                                                                                                                                   { wd: "bewitch" }, { wd: "captivate" }, { wd: "charm" }, { wd: "enchant" }, { wd: "fascinate" }]], \
                 phrase_list: [[{ wd: "get to" }]], near_list: [[{ wd: "bore" }, { wd: "jade" }, { wd: "pall" }, { wd: "tire" }, { wd: "weary" }],
                                                                [{ wd: "underwhelm" }]] }]]
  end
end
