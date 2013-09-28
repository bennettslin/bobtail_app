class AdminsController < ApplicationController

  if Rails.env.production?
    before_action :admin_logged_in!, except: [:show]
  else
    before_action :admin_logged_in!, except: [:show, :new, :create]
  end
  before_action :store_location, except: [:new, :edit, :update]

  def index
    @admins = Admin.all
  end

  def show
    @projects_page = true
    @admins = Admin.all
    @admin = Admin.find(params[:id])
    @admin_projects = Project.where("admin_id == ?", @admin.id).order(:order_num)
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if params[:cancel]
      redirect_back_or(admins_url)
    elsif @admin.save
      flash[:notice] = "New admin created."
      log_in @admin
      redirect_to admins_url
    else
      render "new"
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if params[:cancel]
      redirect_back_or(admins_url)
    elsif @admin.update(admin_params)
      flash[:notice] = "Admin updated."
      redirect_back_or(admins_url)
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
    params.require(:admin).permit(:name, :password, :password_confirmation, :description)
  end
end
