class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages
  
  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  def locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  def set_current_user
    # Here we are using find_by method instead using find because
    # find() raise an exception if the user isn't found, but find_by not.
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    # If this user_id exists on the session cookie (both because the user had signed up or loggin)
    # The user is saved on the attribute user of the Current class
  end

  def protect_pages
    redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
  end
end
