# encoding: UTF-8

require 'spec_helper'
require 'syllable_rules'
require 'syllable_rules/english'
require 'syllabification_context'

module Pronounce
  describe SyllableRules do
    describe '/ng/ cannot start a syllable' do
      subject do
        context = Pronounce::SyllabificationContext.new [], phones, index
        SyllableRules[:en]['/ng/ cannot start a syllable'].evaluate context
      end

      let(:phones) { make_phones %w[AA B NG EH NG ER M OW] }

      context '/ŋ/ in a cluster' do
        let(:index) { 2 }
        it { should == false }
      end

      context 'single /ŋ/' do
        let(:index) { 4 }
        it { should == false }
      end

      context 'other nasals' do
        let(:index) { 6 }
        it { should == nil }
      end

    end
  end
end
