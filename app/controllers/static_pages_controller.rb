class StaticPagesController < ApplicationController

  before_action :store_location, except: [:new, :edit]

  def home
  end

end
