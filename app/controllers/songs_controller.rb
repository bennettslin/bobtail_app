class SongsController < ApplicationController

  before_action :admin_logged_in!, except: [:index, :show]
  before_action :store_location, except: [:new, :edit, :create]

  def index
    @album = Album.first(order: "date ASC")
    redirect_to album_path(@album)
  end

  def show
    @songs_page = true
    @albums = Album.order("date ASC")
    @song = Song.find(params[:id])
    @album = Album.find_by(id: @song.album_id)
    @album_songs = Song.where("album_id = ?", @song.album_id).order(:order_num)
  end

  def new
    unless current_admin.super_admin
      redirect_back_or(albums_url)
    end
    @song = Song.new
    @album = Album.find(params[:album_id]) unless params[:album_id].nil?
  end

  def edit
    @song = Song.find(params[:id])
  end

  def create
    @song = Song.new(songs_params)
    last_num = Song.where("album_id = ?", @song.album_id).maximum("order_num")
    if last_num.nil?
      @song.order_num = 1
    else
      @song.order_num = last_num + 1
    end
    if params[:cancel]
      redirect_back_or(songs_url)
    elsif params[:preview]
      temp_preview_changes
      render "new"
    elsif @song.save
      flash[:notice] = "New song posted."
      redirect_to song_url(@song)
    else
      render "new"
    end
  end

  def update
    @song= Song.find(params[:id])
    if params[:order_up] || params[:order_down]
      params[:order_up] ? increment = -1 : increment = 1
      switch_order_nums(increment)
      redirect_to song_url(@song)
    elsif params[:cancel]
      redirect_back_or(songs_url)
    elsif params[:preview]
      temp_preview_changes
      render "edit"
    elsif @song.update(songs_params)
      flash[:notice] = "Song updated."
      redirect_to song_url(@song)
    else
      render "edit"
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_url
  end

  private

  def songs_params
    params.require(:song).permit(:album_id, :title, :lyrics, :order_num)
  end

  def temp_preview_changes
    @song[:title] = params[:song][:title]
    @song[:lyrics] = params[:song][:lyrics]
    @song[:audio_file] = params[:song][:audio_file]
  end

  def switch_order_nums(increment)
    @album = Album.find_by(id: @song.album_id)
    that_song = Song.where("album_id = ?", @album.id).
      find_by(order_num: (@song.order_num + increment))
    return if that_song.nil?
    this_num = @song.order_num
    that_num = that_song.order_num
    @song.update_attribute(:order_num, that_num)
    that_song.update_attribute(:order_num, this_num)
  end

end
