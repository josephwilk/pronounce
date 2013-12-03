# Pronounce

[![Build Status](https://travis-ci.org/josephwilk/pronounce.png?branch=master)](https://travis-ci.org/josephwilk/pronounce)


Break words up into their <a href="http://en.wikipedia.org/wiki/Syllable">syllables</a> and <a href="http://en.wikipedia.org/wiki/Phone_(phonetics)">phones</a>.

## Usage

```ruby
require 'pronounce'

Pronounce.how_do_i_pronounce('monkeys')
=> [["M", "AH1", "NG"], ["K", "IY0", "Z"]]

```

## Data and Procedure

Pronunciations are based on the CMUdict database: http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/

The phone list is the <a href="http://en.wikipedia.org/wiki/Arpabet">ARPAbet</a> subset used by CMUdict.

#### Vowels

__Monophthongs:__ `AA, AE, AH, AO, EH, IH, IY, UH, UW`  
__Diphthongs:__ `AW, AY, EY, OW, OY`  
__R-colored:__ `ER`  

#### Consonants

__Aspirates:__ `HH`  
__Stops:__ `B, D, G, K, P, T`  
__Affricates:__ `CH, JH`  
__Fricatives:__ `DH, F, SH, S, TH, V, Z, ZH`  
__Nasals:__ `M, N, NG`  
__Liquids:__ `L, R`  
__Semivowels:__ `W, Y`  

CMUdict contains pronunciations of <a href="http://en.wikipedia.org/wiki/North_American_English">North American English</a> and ARPAbet represents the phonemes of <a href="http://en.wikipedia.org/wiki/General_American">General American English</a> so those are currently the only dialect and accent supported.

Syllables are split by scanning the pronunciation from the start to finish and applying rules of <a href="http://en.wikipedia.org/wiki/English_phonology">English phonology</a> to determine if the current phone is the start of a new syllable. Because the pronunciations are corpus based rules only need to split valid words, not determine if a word is valid.

Rules are defined by the rule DSL. A rule can return `:new_syllable`, `:no_new_syllable`, or `:not_applicable` indicating that the rule doesn't apply in the context and other rules should be evaluated.

#### Declaration

```ruby
module Pronounce::SyllableRules
  rule :optional_language, 'name of rule' do
    ...
  end

end
```

## Ruby Support

* MRI 1.9+
* JRuby 1.7.5 (1.9 mode only)
* Rubinius (1.9 mode only)
