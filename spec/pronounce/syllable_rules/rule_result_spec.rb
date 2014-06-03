require 'pronounce/syllable_rules/rule_result'

module Pronounce::SyllableRules
  describe RuleResult do
    describe '#<=>' do
      it 'ranks :new_syllable > :no_new_syllable > :not_applicable' do
        expect(RuleResult.new(:lang, :new_syllable)).to eq RuleResult.new(:lang, :new_syllable)
        expect(RuleResult.new(:lang, :new_syllable)).to be > RuleResult.new(:lang, :no_new_syllable)
        expect(RuleResult.new(:lang, :no_new_syllable)).to be > RuleResult.new(:lang, :not_applicable)
        expect(RuleResult.new(:lang, :not_applicable)).to be < RuleResult.new(:lang, :new_syllable)
      end

      it 'ranks results of base rules lower than other applicable results' do
        expect(RuleResult.new('a rule', :new_syllable)).to eq RuleResult.new('another rule', :new_syllable)
        expect(RuleResult.new(:lang, :no_new_syllable)).to be > RuleResult.new(:base, :new_syllable)
        expect(RuleResult.new(:lang, :not_applicable)).to be < RuleResult.new(:base, :no_new_syllable)
      end

      it 'fails when trying to compare to a non-RuleResult' do
        expect { RuleResult.new(:lang, :new_syllable) > :no_new_syllable }.to raise_error ArgumentError
      end
    end

  end
end
