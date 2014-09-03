module MovesHelper
  def create_title(move)
    if move.mediums.count == 1 && move.mediums.first.present?
      title = signature(move.mediums.first) + ": " + move.title
    else
      title = move.title
    end
    return title
  end

end
