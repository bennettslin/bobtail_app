class ShowsItemsController < ApplicationController

  before_action :admin_logged_in!, except: [:index]
  before_action :store_location, except: [:new, :edit, :update]

  def index
    @shows_page = true # for displaying proper header buttons
    @upcoming_shows = ShowsItem.where(["date >= ?",
      Time.now]).order("date")
    @past_shows = ShowsItem.where(["date <= ?",
      Time.now]).order("date DESC").page params[:page]
  end

  def new
    @shows_item = ShowsItem.new
  end

  def edit
    @shows_item = ShowsItem.find(params[:id])
  end

  def create
    @shows_item = ShowsItem.new(shows_items_params)
    if params[:cancel]
      redirect_back_or(shows_items_url)
    elsif @shows_item.save
      flash[:notice] = "Show posted."
      redirect_to shows_items_url
    else
      render "new"
    end
  end

  def update
    @shows_item= ShowsItem.find(params[:id])
    if params[:cancel]
      redirect_back_or(shows_items_url)
    elsif @shows_item.update(shows_items_params)
      flash[:notice] = "Show updated."
      redirect_to shows_items_url
    else
      render "edit"
    end
  end

  def destroy
    @shows_item = ShowsItem.find(params[:id])
    @shows_item.destroy
    flash[:notice] = "Show deleted."
    redirect_to shows_items_url
  end

  private

  def shows_items_params
    params.require(:shows_item).
      permit(:name, :webpage, :city, :state, :extra, :date)
  end

end
