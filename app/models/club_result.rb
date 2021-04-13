class ClubResult < ApplicationRecord
  belongs_to :club

  validate :result_is_valid

  H_RE_RESULT = {
    drive: /\A[SML][LRC]\*?\z/,
    fw:    /\A(:?S[LRC]-P|[SML][LRC]-Ch|\d{1,2})\z/,
    li:    /\A(:?S[LRC]-P|[SML][LRC]-Ch|\d{1,2})\z/,
    mi:    /\A(:?S[LRC]-P|[SML][LRC]-Ch|\d{1,2})\z/,
    si:    /\A(:?S[LRC]-P|[SML][LRC]-Ch|\d{1,2})\z/,
    p:     /\A(:?[SML][LRC]-Ch|\d{1,2}|\(1\))\z/,
    ch:    /\A(:?Ch|\d{1,2}|IN)\z/,
    sd:    /\A(:?Sd|\d{1,2}|\(1\)|IN)\z/,
    putt:  /\A(:?Miss-A|\d{1,2}(:?-[BCD])?|IN)\z/,
  }.stringify_keys.freeze

  INVALID_RESULTS = %w(MC-Ch)

  def result_is_valid
    re_result = H_RE_RESULT[club.name]
    if re_result && (result !~ re_result || INVALID_RESULTS.include?(result))
      errors.add(:result, "'#{result}' is invalid for #{club} of #{club.player}")
    end
  end

  def repdigit?
    dice.to_s =~ /\A(:?\d)\1\z/
  end
end
