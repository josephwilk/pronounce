require 'spec_helper'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules/rule_evaluation'

module Pronounce::SyllableRules
  describe RuleEvaluation do
    it 'does not allow creation of new instances' do
      expect { RuleEvaluation.new }.to raise_error NoMethodError
    end

    it 'evaluates a rule definition for a context' do
      result = :new_syllable
      expect(RuleEvaluation.result_for(proc { context }, result)).to eq result
    end

    context 'DSL:' do
      describe '#verbatim' do
        it 'wraps a block that exposes the context' do
          result = :new_syllable
          definition = proc { verbatim {|context| context } }
          expect(RuleEvaluation.result_for(definition, result)).to eq result
        end
      end

      describe '#onset' do
        let(:context) {
          Pronounce::SyllabificationContext.new([make_syllable(%w[AA1 N])],
                                                make_phones(%w[AA1 N S EH2 T]),
                                                index) # onset
        }
        let(:definition) { proc { onset proc {|cluster| cluster } } }
        let(:index) { 2 }

        it 'evaluates a proc for the onset cluster of the context' do
          expect(RuleEvaluation.result_for(definition, context)).to eq make_phones(%w[S])
        end

        context "when the current phone isn't in an onset" do
          let(:index) { 3 }

          it 'returns :not_applicable' do
            expect(RuleEvaluation.result_for(definition, context)).to be :not_applicable
          end
        end
      end

      describe '#syllable' do
        let(:context) {
          Pronounce::SyllabificationContext.new([],
                                                make_phones(%w[S IH1 L AH0 B AH0 L]),
                                                index) # syllable
        }
        let(:definition) { proc { syllable proc {|pending_syllable| pending_syllable } } }
        let(:index) { 2 }

        it 'evaluates a proc for the pending syllable of the context' do
          expect(RuleEvaluation.result_for(definition, context).to_strings).to eq %w[S IH1]
        end
      end

      describe '#cannot_be' do
        it 'returns a proc to be evaluated by subject methods' do
          definition = proc { cannot_be :stressed }
          expect(RuleEvaluation.result_for(definition, nil)).to be_an_instance_of Proc
        end

        it 'fails if parameters are not names of interogative method on the subject' do
          matcher = RuleEvaluation.result_for(proc { cannot_be :nope }, nil)
          expect { matcher.call(Object.new) }.to raise_error NoMethodError
        end

        context 'when the parameters evaluate to true on the subject' do
          it 'returns :no_new_syllable' do
            matcher = RuleEvaluation.result_for(proc { cannot_be :frozen }, nil)
            expect(matcher.call(Object.new.freeze)).to be :no_new_syllable
          end
        end

        context 'when the parameters evaluate to false on the subject' do
          it 'returns :not_applicable' do
            matcher = RuleEvaluation.result_for(proc { cannot_be :frozen }, nil)
            expect(matcher.call(Object.new)).to be :not_applicable
          end
        end
      end

      describe '#cannot_match' do
        let(:dsl_subject) { make_phones(%w[CH]) }

        it 'returns a proc to be evaluated by subject methods' do
          definition = proc { cannot_match 'M' }
          expect(RuleEvaluation.result_for(definition, nil)).to be_an_instance_of Proc
        end

        it 'accepts a string from Pronounce.symbols' do
          definition = proc { cannot_match 'AE1' }
          expect { RuleEvaluation.result_for(definition, nil) }.not_to raise_error
        end

        it 'fails if string is not in Pronounce.symbols' do
          matcher = RuleEvaluation.result_for(proc { cannot_match 'nope' }, nil)
          expect { matcher.call(dsl_subject) }.to raise_error ArgumentError
        end

        context 'when the subject matches the parameter' do
          it 'returns :no_new_syllable' do
            matcher = RuleEvaluation.result_for(proc { cannot_match 'CH' }, nil)
            expect(matcher.call(dsl_subject)).to be :no_new_syllable
          end
        end

        context "when the subject doesn't match the parameter" do
          it 'returns :not_applicable' do
            matcher = RuleEvaluation.result_for(proc { cannot_match 'T' }, nil)
            expect(matcher.call(dsl_subject)).to be :not_applicable
          end
        end
      end
    end

  end
end
