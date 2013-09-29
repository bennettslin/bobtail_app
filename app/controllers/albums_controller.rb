class AlbumsController < ApplicationController

  before_action :admin_logged_in!, except: [:show]
  before_action :store_location, except: [:new, :edit, :update]

  def index
    @albums = Album.order("date ASC")
  end

  def show
    @songs_page = true
    @albums = Album.order("date ASC")
    @album = Album.find(params[:id])
    @album_songs = Song.where("album_id == ?", @album.id).order(:order_num)
  end

  def new
    unless current_admin.super_admin
      redirect_back_or(albums_url)
    end
    @album = Album.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(album_params)
    if params[:cancel]
      redirect_back_or(albums_url)
    elsif params[:preview]
      temp_preview_changes
      render "new"
    elsif @album.save
      flash[:notice] = "New album created."
      log_in @album
      redirect_to albums_url
    else
      render "new"
    end
  end

  def update
    @album = Album.find(params[:id])
    if params[:cancel]
      redirect_back_or(albums_url)
    elsif params[:preview]
      temp_preview_changes
      render "edit"
    elsif @album.update(album_params)
      flash[:notice] = "Album updated."
      redirect_back_or(albums_url)
    else
      render "edit"
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Album deleted."
    redirect_to albums_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :date)
  end

  def temp_preview_changes
    @album[:title] = params[:album][:title]
    @album[:description] = params[:album][:description]
    @album[:date] = params[:album][:date]
  end

end
