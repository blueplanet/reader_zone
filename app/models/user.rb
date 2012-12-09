class User < ActiveRecord::Base
  attr_accessible :image, :name, :provider, :uid

  has_many :notes
  
  def self.create_with_omniauth(auth)
    User.create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"] # twitter id
      user.image = auth["info"]["image"]
    end
  end
end
