class LiveTomato < ActiveRecord::Base
  attr_accessible :currenttime, :endtime, :starttime, :title, :username, :userid, :status, :tomato_id, :star_rating, :thumb_rating, :created_at
  belongs_to :tomato

  def remaining_time(id)
    tomato = LiveTomato.find(id)

    endtime = Time.parse(tomato.endtime)
    now = Time.now

    remaining = ((endtime - now) / 60) + 1

    if remaining < 0
      remaining = 0
    else
      remaining.to_i
    end
    if tomato.status == 2
      remaining = 0
    else
      remaining.to_i
    end
  end
end
