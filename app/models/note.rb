class Note < ActiveRecord::Base
  attr_accessible :note, :page, :book, :user

  scope :of_user, lambda { |user_id| where("user_id = ?", user_id) }

  belongs_to :book
  belongs_to :user
end
