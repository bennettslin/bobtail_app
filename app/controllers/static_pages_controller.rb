class StaticPagesController < ApplicationController

  before_action :store_location, except: [:new, :edit]

  def home
  end

  def lyrics
    @lyrics_page = true
  end

end
