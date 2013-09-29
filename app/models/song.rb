class Song < ActiveRecord::Base
  belongs_to :album
  validates :title, presence: true

  def to_param
    "#{id} #{title}".parameterize
  end

end
