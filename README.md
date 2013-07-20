# Pronounce

[![Build Status](https://travis-ci.org/josephwilk/pronounce.png?branch=master)](https://travis-ci.org/josephwilk/pronounce)


Break words up into their <a href="http://en.wikipedia.org/wiki/Syllable">syllables</a> and <a href="http://en.wikipedia.org/wiki/Phone_(phonetics)">phones</a>.

## Usage

```ruby
require 'pronounce'

Pronounce.how_do_i_pronounce('monkeys')
=> [["M", "AH1", "NG"], ["K", "IY0", "Z"]]

Pronounce.symbols
=> ["AA", "AA0", "AA1", "AA2", "AE", "AE0", "AE1", "AE2", "AH", "AH0", "AH1", "AH2", "AO", "AO0", "AO1", "AO2", "AW", "AW0", "AW1", "AW2", "AY", "AY0", "AY1", "AY2", "B", "CH", "D", "DH", "EH", "EH0", "EH1", "EH2", "ER", "ER0", "ER1", "ER2", "EY", "EY0", "EY1", "EY2", "F", "G", "HH", "IH", "IH0", "IH1", "IH2", "IY", "IY0", "IY1", "IY2", "JH", "K", "L", "M", "N", "NG", "OW", "OW0", "OW1", "OW2", "OY", "OY0", "OY1", "OY2", "P", "R", "S", "SH", "T", "TH", "UH", "UH0", "UH1", "UH2", "UW", "UW0", "UW1", "UW2", "V", "W", "Y", "Z", "ZH"]

Pronounce::Phone.all
=> {Pronounce::AA=>vowel, Pronounce::AE=>vowel, Pronounce::AH=>vowel, Pronounce::AO=>vowel, Pronounce::AW=>vowel, Pronounce::AY=>vowel, Pronounce::B=>stop, Pronounce::CH=>affricate, Pronounce::D=>stop, Pronounce::DH=>fricative, Pronounce::EH=>vowel, Pronounce::ER=>vowel, Pronounce::EY=>vowel, Pronounce::F=>fricative, Pronounce::G=>stop, Pronounce::HH=>aspirate, Pronounce::IH=>vowel, Pronounce::IY=>vowel, Pronounce::JH=>affricate, Pronounce::K=>stop, Pronounce::L=>liquid, Pronounce::M=>nasal, Pronounce::N=>nasal, Pronounce::NG=>nasal, Pronounce::OW=>vowel, Pronounce::OY=>vowel, Pronounce::P=>stop, Pronounce::R=>liquid, Pronounce::S=>fricative, Pronounce::SH=>fricative, Pronounce::T=>stop, Pronounce::TH=>fricative, Pronounce::UH=>vowel, Pronounce::UW=>vowel, Pronounce::V=>fricative, Pronounce::W=>semivowel, Pronounce::Y=>semivowel, Pronounce::Z=>fricative, Pronounce::ZH=>fricative}

```

## Data and Procedure

Pronunciations are based on the CMUdict database: http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/

The phone list is the <a href="http://en.wikipedia.org/wiki/Arpabet">ARPAbet</a> subset used by CMUdict.

CMUdict contains pronunciations of <a href="http://en.wikipedia.org/wiki/North_American_English">North American English</a> and ARPAbet represents the phonemes of <a href="http://en.wikipedia.org/wiki/General_American">General American English</a> so those are currently the only dialect and accent supported.

Syllables are split by scanning the pronunciation from the start to finish and applying rules of <a href="http://en.wikipedia.org/wiki/English_phonology">English phonology</a> to determine if the current phone is the start of a new syllable. Rules are defined by the rule DSL. A rule can return a boolean value or `nil` indicating that the rule doesn't apply in the context and other rules should be evaluated.

#### Declaration
```ruby
module Pronounce::SyllableRules
  rule :optional_language, 'name of rule' do |context|
    ...
  end

end
```

## Ruby Support

* MRI 1.9+
* JRuby 1.7.4 (1.9 mode only)
