module CertificationsHelper
  def get_level_title(level)
    title = ""
    if level == 1
      title = "Apprentice"
    elsif  level == 2
      title = "Journeyman"
    elsif  level == 3
      title = "Master"
    end
    return title
  end

  def get_progressbar_width(registration)
    certification = registration.certification

    return (registration.moves.count.to_f/certification.moves_number)*100
  end
end
