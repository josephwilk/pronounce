# encoding: UTF-8

require 'spec_helper'

module Pronounce
  describe Word do
    describe '#syllables' do
      subject { word.syllables.map {|syllable| syllable.to_strings } }

      describe 'returns a list of phones' do
        let(:word) { Word.new ['M', 'AH1', 'NG', 'K'] } # monk
        it { should == [['M', 'AH1', 'NG', 'K']] }
      end

      describe 'groups the phones by syllable' do
        let(:word) { Word.new ['M', 'AH1', 'NG', 'K', 'IY0', 'Z'] } # monkeys
        it { should == [['M', 'AH1', 'NG'], ['K', 'IY0', 'Z']] }
      end

      describe 'applies English rules' do
        context 'for /ŋ/' do
          let(:word) { Word.new ['HH', 'AE1', 'NG', 'IH0', 'NG'] } # hanging
          it { should == [['HH', 'AE1', 'NG'], ['IH0', 'NG']] }
        end

        context 'for light, stressed syllables' do
          let(:word) { Word.new ['HH', 'IH1', 'L', 'AH0', 'K'] } # hillock
          it { should == [['HH', 'IH1', 'L'], ['AH0', 'K']] }
        end
      end
    end

  end
end
