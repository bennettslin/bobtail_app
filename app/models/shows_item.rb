class ShowsItem < ActiveRecord::Base

  before_validation :smart_add_url_protocol

  paginates_per 15
  validates_presence_of :name, :city, :state

  protected

  def smart_add_url_protocol
    if self.webpage.present?
      unless self.webpage == "" || self.webpage[/^http:\/\//] ||
        self.webpage[/^https:\/\//]
        self.webpage = 'http://' + self.webpage
      end
    end
  end

end
