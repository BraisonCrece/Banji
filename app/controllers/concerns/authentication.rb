module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    before_action :protect_pages

    private

    def set_current_user
      # Here we are using find_by method instead using find because
      # find() raise an exception if the user isn't found, but find_by not.
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
      # If this user_id exists on the session cookie (both because the user had signed up or loggin)
      # The user is saved on the attribute user of the Current class
    end

    def protect_pages
      redirect_to new_session_path, alert: t("common.not_logged_in") unless Current.user
    end
  end
end
