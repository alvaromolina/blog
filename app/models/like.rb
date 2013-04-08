class Like < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :user
end
