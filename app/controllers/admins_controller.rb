class AdminsController < ApplicationController

  if Rails.env.production?
    before_action :admin_logged_in!
  else
    before_action :admin_logged_in!, except: [:new]
  end

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = "New admin created."
      log_in @admin
      redirect_to admins_url
    else
      render "new"
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      flash[:notice] = "Admin updated."
      redirect_to admins_url
    else
      render "edit"
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "Admin destroyed."
    redirect_to admins_url
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :password, :password_confirmation)
  end
end
