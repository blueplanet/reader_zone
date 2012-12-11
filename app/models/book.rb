class Book < ActiveRecord::Base
  attr_accessible :description, :image_url, :title

  validates :title, presence: true, uniqueness: true

  has_many :notes
end
