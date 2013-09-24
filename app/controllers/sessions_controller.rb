class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by name: params[:name]
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      flash[:notice] = "You are now logged in."
      redirect_back_or(root_url)
    else
      flash.now[:alert] = "Invalid name or password."
      render "new"
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have logged out."
    redirect_back_or(root_url)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private

  def clear_return_to
    session.delete(:return_to)
  end

end
