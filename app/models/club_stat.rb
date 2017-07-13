class ClubStat
  attr_reader :club

  def initialize(club)
    raise "Illegal argument '#{club.class}' (Club expected)" unless club.is_a?(Club)
    @club = club
    @putting_in_from = {}
  end

  def drive_distance
    return nil unless @club.drive?
    @drive_distance ||= calculate_average { |club_result|
      case club_result.result
      when /\AL/
        100
      when /\AM/
        80
      else
        60
      end
    }
  end

  def fairway_keeping
    return nil unless @club.drive?
    @fairway_keeping ||= calculate_average { |club_result|
      club_result.result =~ /\A.C/ ? 1 : 0
    } * 100
  end

  def drive_pulling
    return nil unless @club.drive?
    @drive_pulling ||= calculate_average { |club_result|
      club_result.result =~ /\A.L/ ? 1 : 0
    } * 100
  end

  def drive_pushing
    return nil unless @club.drive?
    @drive_pushing ||= calculate_average { |club_result|
      club_result.result =~ /\A.R/ ? 1 : 0
    } * 100
  end

  def super_driving
    return nil unless @club.drive?
    @super_driving ||= calculate_average { |club_result|
      club_result.result =~ /\*\z/ ? 1 : 0
    } * 100
  end

  def green_hitting
    return nil if @club.drive? || @club.putt?
    @green_hitting ||= calculate_average { |club_result|
      club_result.result =~ /\A(?:\(?\d+\)?|IN)\z/ ? 1 : 0
    } * 100
  end

  def green_hitting_distance
    return nil if @club.drive? || @club.putt?
    @green_hitting_distance ||= calculate_average { |club_result|
      result = club_result.result
      case result
      when 'IN'
        0
      when '(1)'
        0.5
      when /\A\d+\z/
        result.to_i
      else
        0
      end
    } / green_hitting * 100
  end

  def putting_distance
    return nil unless @club.putt?
    @putting_distance ||= calculate_average { |club_result|
      result = club_result.result
      result == 'IN' ? 60 : result.to_i
    }
  end

  def putting_in_from(distance)
    return nil unless @club.putt?
    @putting_in_from[distance] ||= calculate_average { |club_result|
      result = club_result.result
      result == 'IN' || result.to_i >= distance ? 1 : 0
    } * 100
  end

  def erratic_putting
    return nil unless @club.putt?
    @erratic_putting ||= calculate_average { |club_result|
      club_result.result =~ /-[A-D]\z/ ? 1 : 0
    } * 100
  end

  private

    def calculate_average
      @club.club_results.inject(0.0) { |sum, club_result|
        weight = club_result.repdigit? ? 1 : 2
        sum += yield(club_result) * weight
        sum
      } / 36
    end
end
