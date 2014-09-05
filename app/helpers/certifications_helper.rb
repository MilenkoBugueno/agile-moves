module CertificationsHelper
  def get_level_title(level)
    title = ""
    if level == 1
      title = "Apprentice"
    elsif  level == 2
      title = "Journeyman"
    elsif  level == 2
      title = "Master"
    end
    return title
  end
end
