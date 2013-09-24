class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by name: params[:name]
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      flash[:notice] = "You are now logged in."
      redirect_to admins_url
    else
      flash.now[:alert] = "Invalid name or password."
      render "new"
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have logged out."
    redirect_to root_url
  end

end
