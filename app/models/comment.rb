class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :user
  validates :body, :presence => true
  belongs_to :user

end
