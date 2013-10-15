module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do
    verbatim do |context|
      false if context.current_phone.eql? ::Pronounce::Phone.new 'NG'
    end
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do
    verbatim do |context|
      false if context.pending_syllable.stressed? && context.pending_syllable.light?
    end
  end

  rule :en, 'doublet onsets' do
    verbatim do |context|
      false if context.current_cluster.length == 2 &&
        !context.current_cluster[0].eql?(::Pronounce::Phone.new('S')) &&
        !(context.current_cluster[1].eql?(::Pronounce::Phone.new('Y')) ||
          context.current_cluster[1].approximant? &&
            (context.current_cluster[0].articulation?(:stop) ||
              (context.current_cluster[0].articulation?(:fricative) &&
                context.current_cluster[0].voiceless?)))
    end
  end

  # /s/ may appear before a voiceless stop or fricative which may optionally be
  # followed by an approximant.
  rule :en, '/s/ cluster onsets' do
    verbatim do |context|
      if (context.current_cluster.length == 2 ||
          (context.current_cluster.length == 3 && context.current_cluster[2].approximant?)) &&
        context.current_cluster[0].eql?(::Pronounce::Phone.new('S')) &&
        context.current_cluster[1].voiceless? &&
        context.current_cluster[1].articulation?(:stop, :fricative) &&
        !context.word_end_cluster?

        context.current_phone.eql?(context.current_cluster[0])
      end
    end
  end

end
