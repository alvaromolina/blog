class Post < ActiveRecord::Base
  attr_accessible :body, :title, :status, :likes
  has_many :comments
end
