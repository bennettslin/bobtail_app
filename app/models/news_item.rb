class NewsItem < ActiveRecord::Base
  belongs_to :admin
  validates :heading, length: { minimum: 3 }
  validates :entry, length: { minimum: 10 }

  paginates_per 5
end
