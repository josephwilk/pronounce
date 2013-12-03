module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do
    onset cannot_match 'NG'
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do
    verbatim do |context|
      if context.pending_syllable.stressed? && context.pending_syllable.light?
        :no_new_syllable
      else
        :not_applicable
      end
    end
  end

  rule :en, 'doublet onsets' do
    verbatim do |context|
      if context.current_onset.length == 2 &&
        !(context.current_onset[1].eql?(::Pronounce::Phone.new('Y')) ||
          context.current_onset[1].approximant? &&
            (context.current_onset[0].articulation?(:stop) ||
              (context.current_onset[0].articulation?(:fricative) &&
                context.current_onset[0].voiceless?)))
        :no_new_syllable
      else
        :not_applicable
      end
    end
  end

  # /s/ may appear before a voiceless stop or fricative which may optionally be
  # followed by an approximant.
  rule :en, '/s/ cluster onsets' do
    verbatim do |context|
      if (context.current_onset.length == 2 ||
          (context.current_onset.length == 3 && context.current_onset[2].approximant?)) &&
        context.current_onset[0].eql?(::Pronounce::Phone.new('S')) &&
        context.current_onset[1].voiceless? &&
        context.current_onset[1].articulation?(:stop, :fricative)

        context.current_phone.eql?(context.current_onset[0]) ? :new_syllable : :no_new_syllable
      else
        :not_applicable
      end
    end
  end

end
