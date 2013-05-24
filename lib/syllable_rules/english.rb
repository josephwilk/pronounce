# encoding: UTF-8

module Pronounce::SyllableRules::English
  # /Ŋ/ cannot start a syllable.
  def self.disallow_ng_onset(context)
    false if ::Pronounce::NG === context.current_phone
  end

  # Stressed syllables cannot be light.
  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  def self.stressed_syllables_heavy(context)
    pending_syllable = context.pending_syllable
    false if pending_syllable.stressed? && pending_syllable.light?
  end

end
