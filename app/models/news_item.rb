class NewsItem < ActiveRecord::Base
  belongs_to :admin

  paginates_per 5
end
