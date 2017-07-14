module ClubsHelper

  def stat_name_display(stat_name)
    words = stat_name.to_s.titleize.split
    words = [words.first, words.last] if words.size >= 3
    safe_join(words, '<br>'.html_safe)
  end
end
