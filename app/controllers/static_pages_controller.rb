class StaticPagesController < ApplicationController
  def home
  end

  def audio
    @audio_page = true
  end

  def lyrics
    @lyrics_page = true
  end

  def scores
    @scores_page = true
  end

  def method
    @method_page = true
  end


end
