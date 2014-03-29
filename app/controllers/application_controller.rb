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
end
