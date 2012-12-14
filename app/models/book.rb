class Book < ActiveRecord::Base
  attr_accessible :description, :image_url, :title, :created_by, :created_by_id

  validates :title, presence: true, uniqueness: true

  has_many :notes
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"  
end
