module TomatoesHelper
  def tomato_icon_path(tomato)
    has_team = false
    if tomato.move.present?
      move = tomato.move
      if move.move_type.has_team.present? && move.move_type.has_team
        has_team = true
      end
    end
    state = tomato.state
    if has_team
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

  def tomato_icon_path_at_move(tomato_move, move)
    tomato = tomato_move.tomatoes.first
    state = tomato.state

    extra_planned = false
    # check if extra planned by means of the planned_at time for todo_today and sprint move
    if move.move_type.present? && (move.move_type.make_my_day || move.move_type.make_my_sprint)
      if tomato.move.planned_at.present? && move.planned_at.present?
        if move.state == State.find_by_title("planned") && tomato.move.planned_at > move.planned_at
          extra_planned = true
        end
      end
    elsif state == 3 || state == 4
      extra_planned = true
    end

    has_team = false
    if tomato.move.present?
      move = tomato.move
      if move.move_type.has_team.present? && move.move_type.has_team
        has_team = true
      end
    end

    if has_team
      if !extra_planned
        if state == 1 #planed
          path = "teamtomatengrau.png"
        elsif state == 2 #done
          path = "teamtomatenrot.png"
        else
          path = "teamtomatengrau.png"
        end
      else
        if state == 1 || state == 3 #extra unplanned
          path = "teamtomatenflieder.png"
        elsif state == 4 || state == 2 #extra done
          path = "teamtomatendunkellila.png"
        else
          path = "teamtomatengrau.png"
        end
      end

    else
      if !extra_planned
        if state == 1 #planed
          path = "tomategrau.png"
        elsif state == 2 #done
          path = "tomaterot.png"
        else
          path = "tomategrau.png"
        end
      else
        if state == 4 || state == 2 #extra done
          path = "tomatedunkellila.png"
        else
          path = "tomateflieder.png"
        end

      end
    end

    return path
  end

end
