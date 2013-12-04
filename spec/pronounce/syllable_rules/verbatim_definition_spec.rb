require 'spec_helper'
require 'pronounce/syllable_rules/verbatim_definition'

module Pronounce::SyllableRules
  describe VerbatimDefinition do
    it 'wraps a block with lambda semantics' do
      result = true
      definition = VerbatimDefinition.new proc {|context| return context }
      expect(definition.evaluate result).to eq result
    end

  end
end
