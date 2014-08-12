module TomatoesHelper
  def tomato_icon_path(tomato)
    state = tomato.state
    if tomato.users.count > 1
      if state == 1 #planed
        path = "teamtomatengrau.png"
      elsif state == 2 #done
        path = "teamtomatenrot.png"
      elsif state == 3 #extra unplanned
        path = "teamtomatenflieder.png"
      elsif state == 4 #extra done
        path = "teamtomatendunkellila.png"
      else
        path = "teamtomatengrau.png"
      end
    else
      if state == 1 #planed
        path = "tomategrau.png"
      elsif state == 2 #done
        path = "tomaterot.png"
      elsif state == 3 #extra unplanned
        path = "tomateflieder.png"
      elsif state == 4 #extra done
        path = "tomatedunkellila.png"
      else
        path = "tomategrau.png"
      end
    end

    return path
  end

end
