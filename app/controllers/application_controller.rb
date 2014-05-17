class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

#To set the locale for more than one request.
  before_filter :set_locale
  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

#To prevent routing Error, when setting locale
  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  def log_admin(title)
    @activity = AdminLog.new
    @activity.user_id = current_user
    @activity.username = current_user.name
    @activity.title = title
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.params = params.inspect
    @activity.save
  end
end
