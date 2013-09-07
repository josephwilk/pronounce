# Pronounce

[![Build Status](https://travis-ci.org/josephwilk/pronounce.png?branch=master)](https://travis-ci.org/josephwilk/pronounce)


Break words up into their <a href="http://en.wikipedia.org/wiki/Syllable">syllables</a> and <a href="http://en.wikipedia.org/wiki/Phone_(phonetics)">phones</a>.

## Usage

```ruby
require 'pronounce'

Pronounce.how_do_i_pronounce('monkeys')
=> [["M", "AH1", "NG"], ["K", "IY0", "Z"]]

Pronounce::PhoneType.all
=> {AA=>vowel, AE=>vowel, AH=>vowel, AO=>vowel, AW=>vowel, AY=>vowel, B=>stop, CH=>affricate, D=>stop, DH=>fricative, EH=>vowel, ER=>vowel, EY=>vowel, F=>fricative, G=>stop, HH=>aspirate, IH=>vowel, IY=>vowel, JH=>affricate, K=>stop, L=>liquid, M=>nasal, N=>nasal, NG=>nasal, OW=>vowel, OY=>vowel, P=>stop, R=>liquid, S=>fricative, SH=>fricative, T=>stop, TH=>fricative, UH=>vowel, UW=>vowel, V=>fricative, W=>semivowel, Y=>semivowel, Z=>fricative, ZH=>fricative}

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
* Rubinius (1.9 mode only)
