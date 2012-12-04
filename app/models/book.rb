class Book < ActiveRecord::Base
  attr_accessible :description, :image_url, :title

  has_many :notes
end
