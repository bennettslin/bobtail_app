class Album < ActiveRecord::Base
  has_many :songs
  accepts_nested_attributes_for :songs

  validates :title, presence: true, uniqueness: true

  def to_param
    "#{id} #{title}".parameterize
  end
end
