module TomatoesHelper
  def tomato_icon_path(state)
    if state == 1 #planed
      path = "tomategruen.png"
    elsif state == 2 #done
      path = "tomaterot.png"
    elsif state == 3 #extra unplanned
      path = "tomateflieder.png"
    elsif state == 4 #extra done
      path = "tomatedunkellila.png"
    else
      path = "tomategrau.png"
    end

    return path
  end

end
