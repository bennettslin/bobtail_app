class ShowsItem < ActiveRecord::Base

  before_validation :smart_add_url_protocol

  paginates_per 5
  validates_presence_of :name, :city, :state

  protected

  def smart_add_url_protocol
    unless self.webpage == "" || self.webpage[/^http:\/\//] || self.webpage[/^https:\/\//]
      self.webpage = 'http://' + self.webpage
    end
  end

end
