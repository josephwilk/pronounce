module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do
    if current_phone.eql? ::Pronounce::Phone.new 'NG'
      :no_new_syllable
    else
      :not_applicable
    end
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do
    if pending_syllable.stressed? && pending_syllable.light?
      :no_new_syllable
    else
      :not_applicable
    end
  end

  rule :en, 'doublet onsets' do
    if current_cluster.length == 2 &&
      !current_cluster[0].eql?(::Pronounce::Phone.new('S')) &&
      !(current_cluster[1].eql?(::Pronounce::Phone.new('Y')) ||
        current_cluster[1].approximant? &&
          (current_cluster[0].articulation?(:stop) ||
            (current_cluster[0].articulation?(:fricative) &&
              current_cluster[0].voiceless?)))
      :no_new_syllable
    else
      :not_applicable
    end
  end

  # /s/ may appear before a voiceless stop or fricative which may optionally be
  # followed by an approximant.
  rule :en, '/s/ cluster onsets' do
    if (current_cluster.length == 2 ||
        (current_cluster.length == 3 && current_cluster[2].approximant?)) &&
      current_cluster[0].eql?(::Pronounce::Phone.new('S')) &&
      current_cluster[1].voiceless? &&
      current_cluster[1].articulation?(:stop, :fricative) &&
      !word_end_cluster?

      current_phone.eql?(current_cluster[0]) ? :new_syllable : :no_new_syllable
    else
      :not_applicable
    end
  end

end
