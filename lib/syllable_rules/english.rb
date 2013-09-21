module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do |context|
    false if context.current_phone.eql? ::Pronounce::Phone.new 'NG'
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do |context|
    false if context.pending_syllable.stressed? && context.pending_syllable.light?
  end

  # Triplet onsets must start with /s/, followed by a voiceless stop or
  # fricative, and end with an approximant.
  rule :en, 'triplet onsets' do |context|
    if context.current_cluster.length == 3 &&
      context.current_cluster[0].eql?(::Pronounce::Phone.new('S')) &&
      !context.current_cluster[1].voiced? &&
      context.current_cluster[1].articulation?(:stop, :fricative) &&
      context.current_cluster[2].approximant?

      context.current_phone.eql?(context.current_cluster[0])
    end
  end

end
