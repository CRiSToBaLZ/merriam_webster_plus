## Merriam-Webster Plus

Easily get word definitions, synonyms/antonyms, usage examples, audio pronunciations, and more.

Optimizes core Merriam-Webster APIs to create a singular lexical resource with maximal parts-of-dictionary-entry coverage.

E.g. running 800 words from an official spelling bee list shows the following primary-entry coverage for Merriam-Webster Plus vs. its component sources:

| Lexical Resource                          | Part of Speech | Definition | Example Sentence | Audio |
| ----------------------------------------- |:--------------:| ----------:| ----------------:| -----:|
| Merriam-Webster Plus                      | 99%            | 99%        | 87%              | 92%   |
| Merriam-Webster's Collegiate  Dictionary  | 94%            | 94%        | 59%              | 89%   |
| Merriam-Webster's Collegiate  Thesaurus   | 87%            | 87%        | 82%              | 0%    |


## Usage

Set `ENV["COLLEGIATE_DICTIONARY_API_KEY"]` and `ENV["COLLEGIATE_THESAURUS_API_KEY"]` with eponymous keys from https://dictionaryapi.com/register/index.

```ruby
>> require "merriam_webster_plus"
>> lookup = MerriamWebsterPlus::DictionaryPlus.new(word: "run")
```
```
>> puts lookup.primary_entry.to_yaml
---
:word: run                                                                                 
:class: verb                                                                               
:definition: to go at a pace faster than a walk                                            
:example: we ran all the way to the bus stop, but still missed the bus                     
:audio: https://media.merriam-webster.com/audio/prons/en/us/mp3/r/run00001.mp3  
```

```
>> puts lookup.entries.to_yaml
---
- :word: run                                                                               
  :class: verb                                                                             
  :audio: https://media.merriam-webster.com/audio/prons/en/us/mp3/r/run00001.mp3           
  :senses:                                                                                 
  - - 1                                                                                    
    - :definition: to go at a pace faster than a walk                                      
      :synonyms: dash, gallop, jog, scamper, sprint, trip, trot                      
      :related_words: bound, canter, leap, lope, shag, skip, spring                  
      :near_antonyms: amble, saunter, shamble, shuffle, stroll                       
      :example: we ran all the way to the bus stop, but still missed the bus         
  - - 2                                                                              
    - :definition: to hasten away from something dangerous or frightening            
      :synonyms: bolt, break, bug out, flee, fly, hightail (it), retreat, run away,  
        run off, skedaddle                                                           
      :related_words: abscond, clear out, decamp, elope, escape, get (away), get out,
        lam, light out, make off, mizzle, scarper, scat, scram, skip (out), skirr
      :synonymous_phrases: beat a retreat, beat it, make tracks, turn tail
      :near_antonyms: beard, brave, confront, dare, defy, face
      :example: rather than run from a black bear, it's better to hold your ground
        and make lots of noise
  - - 3
    - :definition: to be positioned along a certain course or in a certain direction
      :synonyms: bear, extend, go, head, lead, lie
      :related_words: cross, cut, pass
      :example: the road runs along the river for a while
- :word: run
  :class: noun
  :audio: https://media.merriam-webster.com/audio/prons/en/us/mp3/r/run00001.mp3
  :senses:
  - - 1
    - :definition: a prevailing or general movement or inclination
      :synonyms: current, direction, drift, leaning, tendency, tide, trend, wind
      :related_words: curve, downside, shift, swing, turn, turnabout, upside
      :example: the company's stock has remained consistent with the overall run of
        the market
  - - 2
    - :definition: a natural body of running water smaller than a river
      :synonyms: beck, bourn, brook, brooklet, burn, creek, gill, rill, rivulet, runlet,
        runnel, streamlet
      :related_words: arroyo, billabong, fresh, freshet, runoff
      :example: a run full of catfish
  - - 3
    - :definition: the period during which something exists, lasts, or is in progress
      :synonyms: continuance, date, duration, life, life span, lifetime, standing,
        time
      :related_words: spell, stretch
      :example: the actor has been assigned the part for the run of the show

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CRiSToBaLZ/merriam_webster_plus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
