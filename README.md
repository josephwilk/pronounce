# Pronounce

Break words up into their <a href="http://en.wikipedia.org/wiki/Phone_(phonetics)">phones</a>.

##Usage

```ruby
require 'pronounce'

Pronounce.how_do_i_pronounce('monkeys')
=> ["M", "AH1", "NG", "K", "IY0", "Z"]

Pronounce.symbols
=> ["AA", "AA0", "AA1", "AA2", "AE", "AE0", "AE1", "AE2", "AH", "AH0", "AH1", "AH2", "AO", "AO0", "AO1", "AO2", "AW", "AW0", "AW1", "AW2", "AY", "AY0", "AY1", "AY2", "B", "CH", "D", "DH", "EH", "EH0", "EH1", "EH2", "ER", "ER0", "ER1", "ER2", "EY", "EY0", "EY1", "EY2", "F", "G", "HH", "IH", "IH0", "IH1", "IH2", "IY", "IY0", "IY1", "IY2", "JH", "K", "L", "M", "N", "NG", "OW", "OW0", "OW1", "OW2", "OY", "OY0", "OY1", "OY2", "P", "R", "S", "SH", "T", "TH", "UH", "UH0", "UH1", "UH2", "UW", "UW0", "UW1", "UW2", "V", "W", "Y", "Z", "ZH"]

Pronounce.phones
=> {"EY"=>"vowel", "EH"=>"vowel", "ER"=>"vowel", "HH"=>"aspirate", "SH"=>"fricative", "ZH"=>"fricative", "UH"=>"vowel", "JH"=>"affricate", "DH"=>"fricative", "UW"=>"vowel", "AW"=>"vowel", "AH"=>"vowel", "AA"=>"vowel", "AE"=>"vowel", "AO"=>"vowel", "AY"=>"vowel", "OW"=>"vowel", "OY"=>"vowel", "Y"=>"semivowel", "V"=>"fricative", "T"=>"stop", "S"=>"fricative", "P"=>"stop", "N"=>"nasal", "L"=>"liquid", "IH"=>"vowel", "G"=>"stop", "D"=>"stop", "B"=>"stop", "CH"=>"affricate", "F"=>"fricative", "IY"=>"vowel", "K"=>"stop", "M"=>"nasal", "R"=>"liquid", "TH"=>"fricative", "W"=>"semivowel", "Z"=>"fricative", "NG"=>"nasal"}

```

##Data

Based on the cmudict database: http://cmusphinx.svn.sourceforge.net/viewvc/cmusphinx/trunk/cmudict/
