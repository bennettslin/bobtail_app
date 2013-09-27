class Project < ActiveRecord::Base
  belongs_to :admin
  validates :title, length: { minimum: 3 }
  validates :description, length: { minimum: 10 }

end
