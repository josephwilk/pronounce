# Pronounce

Break words up into their <a href="http://en.wikipedia.org/wiki/Phone_(phonetics)">phones</a>.

##Usage

```ruby
require 'pronounce'

Pronounce.how_do_i_pronounce('monkeys')
=> ["M", "AH1", "NG", "K", "IY0", "Z"]
```

##Data

Based on the cmudict database: http://cmusphinx.svn.sourceforge.net/viewvc/cmusphinx/trunk/cmudict/
