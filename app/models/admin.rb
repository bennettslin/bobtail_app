class Admin < ActiveRecord::Base
  has_many :news_items
  has_many :projects
  accepts_nested_attributes_for :projects

  has_secure_password
  validates :name, presence: true, uniqueness: true

  def name=(value)
    value = value.strip.capitalize
    write_attribute :name, value
  end

  def to_param
    "#{id} #{name}".parameterize
  end

end
