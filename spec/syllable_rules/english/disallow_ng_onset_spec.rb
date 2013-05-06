# encoding: UTF-8

require 'spec_helper'
require 'syllable_rules/english/disallow_ng_onset'

module Pronounce::SyllableRules::English
  describe DisallowNGOnset do
    subject do
      context = Pronounce::SyllabificationContext.new [], phones, index
      DisallowNGOnset.evaluate context
    end

    let(:phones) { make_phones %w{AA B NG EH NG ER M OW} }

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
