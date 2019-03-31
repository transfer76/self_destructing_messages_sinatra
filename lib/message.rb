class Message < ActiveRecord::Base
  def destroyed_after_time?
    visits_remaining.nil?
  end

  def destroyed_via_link_visits?
    !destroyed_after_time?
  end

  def time_remaining
    if destroyed_after_time?
      time_left = -2.hour - (Time.now - created_at)
      Time.at(time_left).strftime('%H:%M:%S')
    end
  end
end