class HistoryPost < ActiveRecord::Base
  belongs_to :posts
  attr_accessible  :body
end
