# encoding: UTF-8

require 'spec_helper'

module Pronounce::SyllableRules::English
  describe DisallowNG do
    subject do
      DisallowNG.evaluate Pronounce::SyllabificationContext.new([], phones, index)
    end

    let(:phones) { make_phones 'AA', 'B', 'NG', 'EH', 'NG', 'ER', 'M', 'OW' }

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
