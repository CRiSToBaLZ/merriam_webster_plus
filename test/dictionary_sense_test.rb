require "test_helper"

class DictionarySenseTest < Minitest::Test
  def setup
    definition = "to produce an effect upon (someone or something)"
    sense_group = sense_group_snippet

    @valid_primary_sense =
      MerriamWebsterPlus::DictionarySense.new(definition: definition, sense_group: sense_group).primary_sense
  end

  def test_valid_main_sense_dictionary
    assert_equal "to produce an effect upon (someone or something)", @valid_primary_sense[:definition]
    assert_equal "Rainfall affects plant growth.", @valid_primary_sense[:example]
  end

  private

  def sense_group_snippet
    [["bs", { sense: { dt: [["text", "{bc}to produce an effect upon (someone or something):"]] } }], ["sense", { sn: "a",
                                                                                                                 dt: [["text", "{bc}to act on and cause a change in (someone or something) "], ["vis",
                                                                                                                                                                                                [{ t: "Rainfall {wi}affects{/wi} plant growth." }, { t: "areas to be {wi}affected{/wi} by highway construction" },
                                                                                                                                                                                                 { t: "The protein plays a central role in metabolism … which in turn {wi}affects{/wi} the rate of aging.",
                                                                                                                                                                                                   aq: { auth: "Stephen S. Hall" } },
                                                                                                                                                                                                 { t: "The 1883 eruption of Krakatau in what is now Indonesia {wi}affected{/wi} global sunsets for years …",
                                                                                                                                                                                                   aq: { auth: "Evelyn Browning Garriss" } },
                                                                                                                                                                                                 { t: "Before the 1980s it was not at all clear how nicotine {wi}affected{/wi} the brain.",
                                                                                                                                                                                                   aq: { auth: "Cynthia Kuhn et al." } }]]] }], ["sense", { sn: "b",
                                                                                                                                                                                                                                                            dt: [["text", "{bc}to cause illness, symptoms, etc., in (someone or something) "], ["vis",
                                                                                                                                                                                                                                                                                                                                                [{ t: "a disease that {wi}affects{/wi} millions of patients each year" },
                                                                                                                                                                                                                                                                                                                                                 { t: "… the syndrome can {wi}affect{/wi} the pancreas, which produces insulin …",
                                                                                                                                                                                                                                                                                                                                                   aq: { auth: "H. Lee Kagan" } }]]] }], ["sense", { sn: "c",
                                                                                                                                                                                                                                                                                                                                                                                                     dt: [["text", "{bc}to produce an emotional response in (someone) "], ["vis",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           [{ t: "an experience that {wi}affected{/wi} him powerfully" },
                                                                                                                                                                                                                                                                                                                                                                                                                                                                            { t: "… she traveled to Cuba and was deeply {wi}affected{/wi} by what she saw.",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                              aq: { auth: "Elsa Dixler" } }]]] }], ["sense", { sn: "d", dt: [["text", "{bc}to influence (someone or something) "],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ["vis",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              [{ t: "trying not to let emotions {wi}affect{/wi} their decision" }]]] }]]
  end
end
