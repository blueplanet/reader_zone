class Note < ActiveRecord::Base
  attr_accessible :note, :page, :book_id

  belongs_to :book
end
