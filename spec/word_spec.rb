# encoding: UTF-8

require 'spec_helper'

module Pronounce
  describe Word do
    describe '.syllables' do
      subject { word.syllables.map {|syllable| syllable.to_strings } }

      describe 'returns a list of phones' do
        let(:word) { Word.new ['M', 'AH1', 'NG', 'K'] }
        it { should == [['M', 'AH1', 'NG', 'K']] }
      end

      describe 'groups the phones by syllable' do
        let(:word) { Word.new ['M', 'AH1', 'NG', 'K', 'IY0', 'Z'] }
        it { should == [['M', 'AH1', 'NG'], ['K', 'IY0', 'Z']] }
      end

      describe 'applies English rules' do
        context 'for /ŋ/' do
          let(:word) { Word.new ['HH', 'AE1', 'NG', 'IH0', 'NG'] }
          it { should == [['HH', 'AE1', 'NG'], ['IH0', 'NG']] }
        end
      end
    end

  end
end
