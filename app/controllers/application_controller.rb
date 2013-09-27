class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_admin, :current_admin?, :redirect_back_or

  private

  def admin_logged_in!
    return if current_admin?
    flash[:alert] = "Please log in."
    store_location
    redirect_to login_url
  end

  def log_in(admin)
    session[:admin_id] = admin.id if admin.present?
  end

  def log_out
    session[:admin_id] = nil
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if
      session[:admin_id]
  end

  def current_admin?
    current_admin.present?
  end

  # remembers page from which admin is forced to login
  def store_location
    session[:return_to] = request.original_url
  end

  def clear_return_to
    session.delete(:return_to)
  end

  # redirects admin back to page that forced login
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

end
