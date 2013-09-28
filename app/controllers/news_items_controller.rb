class NewsItemsController < ApplicationController

  before_action :admin_logged_in!, except: [:index]
  before_action :store_location, except: [:new, :edit, :update]

  def index
    @news_page = true # for displaying proper header buttons
    @news_items = NewsItem.order("created_at DESC").page params[:page]
  end

  def new
    @news_item = NewsItem.new
  end

  def edit
    @news_item = NewsItem.find(params[:id])
  end

  def create
    @news_item = NewsItem.new(news_items_params)
    @news_item.admin_name = current_admin.name
    # admin name for news item will persist even if admin is later deleted
    if params[:cancel]
      redirect_back_or(news_items_url)
    elsif params[:preview]
      temp_preview_changes
      render "new"
    elsif @news_item.save
      flash[:notice] = "News item posted."
      redirect_to news_items_url
    else
      render "new"
    end
  end

  def update
    @news_item= NewsItem.find(params[:id])
    if params[:cancel]
      redirect_back_or(news_items_url)
    elsif params[:preview]
      temp_preview_changes
      render "edit"
    elsif @news_item.update(news_items_params)
      flash[:notice] = "News item updated."
      redirect_to news_items_url
    else
      render "edit"
    end
  end

  def destroy
    @news_item = NewsItem.find(params[:id])
    @news_item.destroy
    flash[:notice] = "News item deleted."
    redirect_to news_items_url
  end

  private

  def news_items_params
    params.require(:news_item).permit(:heading, :entry)
  end

  def temp_preview_changes
    @news_item[:heading] = params[:news_item][:heading]
    @news_item[:entry] = params[:news_item][:entry]
  end

end
