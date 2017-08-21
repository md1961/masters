module PlayerClubStatSuitesHelper

  def old_club_denote(player, club_name, rowspan = 2)
    label, clazz = player.has_old_club?(club_name) ? ['D'               , 'old_club'] \
                                                   : ['&nbsp;'.html_safe, ''        ]
    content_tag :td, rowspan: rowspan, align: 'center' do
      content_tag :span, class: clazz do
        label
      end
    end
  end
end
