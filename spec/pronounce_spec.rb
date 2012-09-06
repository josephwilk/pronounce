require File.dirname(__FILE__) + '/../lib/pronounce'

describe Pronounce do
  describe ".how_do_i_pronounce" do
    it "should return a list of phones" do
      Pronounce.how_do_i_pronounce("monkeys").should == ["M", "AH1", "NG", "K", "IY0", "Z"]
    end
  end
  
  describe ".symbols" do
    it "should list all symbols" do
      Pronounce.symbols.should == ["AA", "AA0", "AA1", "AA2", "AE", "AE0", "AE1", 
                                   "AE2", "AH", "AH0", "AH1", "AH2", "AO", "AO0", 
                                   "AO1", "AO2", "AW", "AW0", "AW1", "AW2", "AY", 
                                   "AY0", "AY1", "AY2", "B", "CH", "D", "DH", "EH", 
                                   "EH0", "EH1", "EH2", "ER", "ER0", "ER1", "ER2", 
                                   "EY", "EY0", "EY1", "EY2", "F", "G", "HH", "IH", 
                                   "IH0", "IH1", "IH2", "IY", "IY0", "IY1", "IY2", 
                                   "JH", "K", "L", "M", "N", "NG", "OW", "OW0", 
                                   "OW1", "OW2", "OY", "OY0", "OY1", "OY2", "P", 
                                   "R", "S", "SH", "T", "TH", "UH", "UH0", "UH1", 
                                   "UH2", "UW", "UW0", "UW1", "UW2", "V", "W", "Y", 
                                   "Z", "ZH"]
    end
  end
  
  describe ".phones" do
    it "should list all phones with types" do
      Pronounce.phones.should == {"AA" => "vowel",
                                  "AE" => "vowel",
                                  "AH" => "vowel",
                                  "AO" => "vowel",
                                  "AW" => "vowel",
                                  "AY" => "vowel",
                                  "B" => "stop",
                                  "CH" => "affricate",
                                  "D" => "stop",
                                  "DH" => "fricative",
                                  "EH" => "vowel",
                                  "ER" => "vowel",
                                  "EY" => "vowel",
                                  "F" => "fricative",
                                  "G" => "stop",
                                  "HH" => "aspirate",
                                  "IH" => "vowel",
                                  "IY" => "vowel",
                                  "JH" => "affricate",
                                  "K" => "stop",
                                  "L" => "liquid",
                                  "M" => "nasal",
                                  "N" => "nasal",
                                  "NG" => "nasal",
                                  "OW" => "vowel",
                                  "OY" => "vowel",
                                  "P" => "stop",
                                  "R" => "liquid",
                                  "S" => "fricative",
                                  "SH" => "fricative",
                                  "T" => "stop",
                                  "TH" => "fricative",
                                  "UH" => "vowel",
                                  "UW" => "vowel",
                                  "V" => "fricative",
                                  "W" => "semivowel",
                                  "Y" => "semivowel",
                                  "Z" => "fricative",
                                  "ZH" => "fricative"}
    end
  end
  
end
