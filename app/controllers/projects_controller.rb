class ProjectsController < ApplicationController

  before_action :admin_logged_in!, except: [:index, :show]
  before_action :store_location, except: [:new, :edit, :create]

  def index
    @admin = Admin.first(order: "created_at ASC")
    redirect_to admin_path(@admin)
  end

  def show
    @projects_page = true
    @admins = Admin.all
    @project = Project.find(params[:id])
    @admin = Admin.find_by(id: @project.admin_id)
    @admin_projects = Project.where("admin_id = ?", @admin.id).order(:order_num)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
    unless @project.admin_id == current_admin.id ||
      current_admin.super_admin
      redirect_back_or(projects_url)
    end
  end

  def create
    @project = Project.new(projects_params)
    @project.admin_id = current_admin.id
    last_num = Project.where("admin_id = ?", current_admin.id).maximum("order_num")
    if last_num.nil?
      @project.order_num = 1
    else
      @project.order_num = last_num + 1
    end
    if params[:cancel]
      redirect_back_or(projects_url)
    elsif params[:preview]
      temp_preview_changes
      render "new"
    elsif @project.save
      flash[:notice] = "New project posted."
      redirect_to project_url(@project)
    else
      render "new"
    end
  end

  def update
    @project= Project.find(params[:id])
    if params[:order_up] || params[:order_down]
      params[:order_up] ? increment = -1 : increment = 1
      switch_order_nums(increment)
      redirect_to project_url(@project)
    elsif params[:cancel]
      redirect_back_or(projects_url)
    elsif params[:preview]
      temp_preview_changes
      render "edit"
    elsif @project.update(projects_params)
      flash[:notice] = "Project updated."
      redirect_to project_url(@project)
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project deleted."
    redirect_to projects_url
  end

  private

  def projects_params
    params.require(:project).permit(:admin_id, :title, :description, :order_num)
  end

  def temp_preview_changes
    @project[:title] = params[:project][:title]
    @project[:description] = params[:project][:description]
  end

  def switch_order_nums(increment)
    @admin = Admin.find_by(id: @project.admin_id)
    that_project = Project.where("admin_id = ?", @admin.id).
      find_by(order_num: (@project.order_num + increment))
    return if that_project.nil?
    this_num = @project.order_num
    that_num = that_project.order_num
    @project.update_attribute(:order_num, that_num)
    that_project.update_attribute(:order_num, this_num)
    # flash[:notice] = "Project reordered."
    # flash isn't necessary after all, because feedback is instant;
    # plus it feels smoother without it
  end

end
