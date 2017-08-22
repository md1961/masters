module PlayerClubStatSuitesHelper

  def old_club_denote(player, club_name, rowspan = 2)
    num_old_clubs = player.old_clubs.where(name: club_name).count
    label, clazz = num_old_clubs.zero? ? ['&nbsp;'.html_safe, ''        ] \
                                       : [num_old_clubs.to_s, 'old_club']
    content_tag :td, rowspan: rowspan, align: 'center' do
      content_tag :span, class: clazz, title: 'Restore Old' do
        label
      end
    end
  end
end
