class Post < ActiveRecord::Base
  validate :body_cant_have_words_foo_or_bar, :on => :create

  attr_accessible :body, :title, :status, :likes, :category
  has_many :comments
  has_many :likes
  has_many :history_posts
  belongs_to :user
  
  validates :body, :presence => true
  validates :body, :uniqueness => true

  before_save :save_history

  def body_cant_have_words_foo_or_bar
  	if (body.downcase.split(" ").include?("foo") or body.downcase.split(" ").include?("bar"))
		errors.add(:body, "cant have the words foo or bar")
  	end
  end

  def user_liked(user)
    likes.each  do |like|
      if like.user.email == user.email
        return true
      end
    end
    false
  end

  def save_history
    self.history_posts.build(:body=>self.body)
  end

  #after_save do |post|
    #post.history_posts.build(:body=>post.body)
    #post.save
    #h = HistoryPost.new
    #h.post_id = post.id
    #h.body = post.body
    #h.save
  #end
  #before_save do |post|
    #post.history_posts.build(:body=>post.body)
  #end 




end
