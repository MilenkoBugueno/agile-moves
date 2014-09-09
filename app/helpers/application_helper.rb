module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
    return ""
  end

  def default_edit_permissions(user, object)
    if !object.present? || !user.present?
    elsif object.user.present? && object.users.present?
      ret_val =  (user.has_role? :admin) || (user.id == object.user_id)  || (object.users.include? user)
    elsif object.user.present?
      ret_val =  (user.has_role? :admin) || (user.id == object.user_id)
    else
      ret_val =  false
    end

    return ret_val

  end

end
