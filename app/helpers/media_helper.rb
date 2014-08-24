module MediaHelper
  def signature(medium)
    if medium.title.present? && medium.composer.present? && medium.catalog.present?
      signature = (medium.composer[0..3].upcase() + medium.title[0..3].downcase() + medium.catalog).gsub(/\s+/, "")
    end

    return signature
  end
end
