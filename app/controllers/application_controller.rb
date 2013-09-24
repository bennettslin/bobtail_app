class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_admin, :current_admin?, :dev_or_test?

  private

  def admin_logged_in!
    return if current_admin.present?
    flash[:alert] = "Please log in."
    redirect_to login_url
  end

  def log_in(admin)
    session[:admin_id] = admin.id if admin.present?
  end

  def log_out
    session[:admin_id] = nil
  end

  def current_admin
    @current_admin ||= Admin.find_by id: session[:admin_id] if
      session[:admin_id]
  end

  def current_admin?
    current_admin.present?
  end

  def dev_or_test?
    Rails.env.development? || Rails.env.test?
  end

end
